module Spree::Api::V2::Storefront
  module CartControllerDecorator
    def add_item
      spree_authorize! :update, spree_current_order, order_token
      # spree_authorize! :show, @variant

      result = add_item_service.call(
          order: spree_current_order,
          variant: @variant,
          quantity: params[:quantity],
          options: params[:options]
      )

      render_order(result)
    end
  end
end


Spree::Api::V2::Storefront::CartController.prepend Spree::Api::V2::Storefront::CartControllerDecorator