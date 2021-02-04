module Spree
  module Api
    module V1
      module TaxonsControllerDecorator
        def index
          @taxons = if params[:taxonomy_id].present?
                      ::Spree::Taxon.accessible_by(current_ability).where(taxonomy_id: params[:taxonomy_id])
                    elsif params[:ids]
                      ::Spree::Taxon.includes(:children).accessible_by(current_ability).where(id: params[:ids].split(','))
                    else
                      ::Spree::Taxon.includes(:children).accessible_by(current_ability).order(:taxonomy_id, :lft)
                    end

          @taxons = @taxons.ransack(params[:q]).result
          @taxons = @taxons.page(params[:page]).per(params[:per_page])
          respond_with(@taxons)
        end
      end
    end
  end
end


Spree::Api::V1::TaxonsController.prepend Spree::Api::V1::TaxonsControllerDecorator
