require 'digest'
module Spree
  module NavigationHelper
    def spree_navigation_data
      if ::Spree::Config.has_preference? :main_nav and ::Spree::Config[:main_nav].present?
        config = YAML.load(Spree::Config[:main_nav]).with_indifferent_access
        config.dig(current_store.code, :navigation) || config.dig(:default, :navigation) || []
      else
        SpreeStorefrontConfig.dig(current_store.code, :navigation) || SpreeStorefrontConfig.dig(:default, :navigation) || []
      end
        # safeguard for older Spree installs that don't have spree_navigation initializer
        # or spree.yml file present
    rescue
      []
    end

  end
end

