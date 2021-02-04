module SpreeThemeConfig
  module Spree
    module AppConfigurationDecorator
      def self.prepended(base)
        base.preference :main_nav, :text
        base.preference :google_ad_id, :string
        base.preference :google_ad_conversion_id, :string
        base.preference :homepage_category_ids, :string
        base.preference :head_extra_codes, :text
        base.preference :footer_extra_codes, :text
        base.preference :product_tabs, :string
        base.preference :top_announcement, :string
        base.preference :expedited_shipping_days, :string
        base.preference :standard_shipping_days, :string
        base.preference :return_text, :string
      end
    end
  end
end
::Spree::AppConfiguration.prepend SpreeThemeConfig::Spree::AppConfigurationDecorator