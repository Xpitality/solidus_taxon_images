# frozen_string_literal: true

module Spree
  module Admin
    class ImagesController < ResourceController
      before_action :load_data
      create.before :set_viewable
      update.before :set_viewable

      private

      def location_after_destroy
        if @product
          admin_product_images_url(@product)
        else
          admin_taxon_images_url(@taxon.id)
        end
      end

      def location_after_save
        if @product
          admin_product_images_url(@product)
        else
          admin_taxon_images_url(@taxon.id)
        end
      end

      def load_data
        if params[:product_id]
          @product = Spree::Product.friendly.find(params[:product_id])
          @variants = @product.variants.collect do |variant|
            [variant.sku_and_options_text, variant.id]
          end
          @variants.insert(0, [t('spree.all'), @product.master.id])
        else
          @taxon = Spree::Taxon.find(params[:taxon_id])
        end
      rescue ActiveRecord::RecordNotFound
        if params[:product_id]
          resource_not_found(flash_class: Spree::Product, redirect_url: admin_products_path)
        else
          resource_not_found(flash_class: Spree::Taxon, redirect_url: admin_taxons_path)
        end
      end

      def model_class
        if params[:taxon_id]
          Spree::TaxonImage
        else
          "Spree::#{controller_name.classify}".constantize
        end
      end

      def permitted_resource_params
        if params[:taxon_id] && object_name == 'image' && action_name == 'update'
          params.require("taxon_image").permit!
        else
          params[object_name].present? ? params.require(object_name).permit! : ActionController::Parameters.new.permit!
        end
      end

      def collection_url(options = {})
        if parent?
          spree.polymorphic_url([:admin, parent, model_class], options)
        elsif params[:taxon_id] && action_name == "destroy"
          api_taxon_images_path(params[:taxon_id])
        else
          spree.polymorphic_url([:admin, model_class], options)
        end
      end

      def set_viewable
        if @product
          @image.viewable_type = 'Spree::Variant'
        else
          @image.viewable_type = 'Spree::Taxon'
        end
        if params[:image]
          @image.viewable_id = params[:image][:viewable_id]
        elsif params[:taxon_image]
          @image.viewable_id = params[:taxon_id] || params[:taxon_image][:viewable_id]
        end
      end
    end
  end
end
