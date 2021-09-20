module SpreeThemeConfig
  module Spree
    module PaymentMethodDecorator
      def login
        if has_preference? :login
          get_preference :login
        else
          ''
        end
      end
    end
  end
end
::Spree::PaymentMethod.prepend SpreeThemeConfig::Spree::PaymentMethodDecorator
