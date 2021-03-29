# frozen_string_literal: true

module Spree
  class TaxonImage < Asset
    include ::Spree::TaxonImage::PaperclipAttachment

    def mini_url
      Spree::Deprecation.warn(
        'Spree::TaxonImage#mini_url is DEPRECATED. Use Spree::TaxonImage#url(:mini) instead.'
      )
      url(:mini)
    end
  end
end
