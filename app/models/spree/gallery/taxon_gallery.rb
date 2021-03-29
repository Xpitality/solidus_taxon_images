# frozen_string_literal: true

module Spree
  module Gallery
    class TaxonGallery
      def initialize(taxon)
        @taxon = taxon
      end

      # A list of all images associated with this gallery
      #
      # @return [Enumerable<Spree::Image>] all images in the gallery
      def images
        @images ||= @taxon.images
      end
    end
  end
end
