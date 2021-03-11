module SpreeThemeConfig
  module Spree
    module Search
      module BaseDecorator
        def retrieve_products
          @products = extended_base_scope&.available
          curr_page = page || 1

          unless ::Spree::Config.show_products_without_price
            @products = @products.where('spree_prices.amount > 0').
                where('spree_prices.currency' => current_currency)
          end
          @products = @products.page(curr_page).per(per_page)
        end
      end
    end
  end
end


::Spree::Core::Search::Base.prepend SpreeThemeConfig::Spree::Search::BaseDecorator