module SpreeThemeConfig
  module Spree
    module PaymentMethodDecorator
      def login
        get_preference :login
      end
    end
  end
end
::Spree::PaymentMethod.prepend SpreeThemeConfig::Spree::PaymentMethodDecorator