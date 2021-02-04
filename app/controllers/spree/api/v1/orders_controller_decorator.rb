module Spree
  module Api
    module V1
      module OrdersControllerDecorator
        def index
          authorize! :index, ::Spree::Order
          @orders = ::Spree::Order.includes(:line_items, :ship_address, :bill_address, :shipments, :payments).ransack(params[:q]).result.page(params[:page]).per(params[:per_page])
          respond_with(@orders)
        end
      end
    end
  end
end

Spree::Api::V1::OrdersController.prepend Spree::Api::V1::OrdersControllerDecorator
