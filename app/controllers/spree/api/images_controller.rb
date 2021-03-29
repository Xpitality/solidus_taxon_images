# frozen_string_literal: true

module Spree
  module Api
    class ImagesController < Spree::Api::BaseController
      def index
        @images = scope.images.accessible_by(current_ability)
        respond_with(@images)
      end

      def show
        @image = scope.images.accessible_by(current_ability, :show).find(params[:id])
        respond_with(@image)
      end

      def create
        authorize! :create, Image
        @image = scope.images.create(image_params)
        respond_with(@image, status: 201, default_template: :show)
      end

      def update
        @image = scope.gallery.images.accessible_by(current_ability, :update).find(params[:id])
        @image.update(image_params)
        respond_with(@image, default_template: :show)
      end

      def destroy
        @image = scope.images.accessible_by(current_ability, :destroy).find(params[:id])
        @image.destroy
        respond_with(@image, status: 204)
      end

      private

      def image_params
        if params[:taxon_id]
          params.require(:taxon_image).permit(permitted_image_attributes)
        else
          params.require(:image).permit(permitted_image_attributes)
        end
      end

      def scope
        if params[:taxon_id]
          Spree::Taxon.find(params[:taxon_id])
        elsif params[:product_id]
          Spree::Product.friendly.find(params[:product_id])
        elsif params[:variant_id]
          Spree::Variant.find(params[:variant_id])
        end
      end
    end
  end
end
