require "open-uri"

module Spree
  module Api
    module V1
      module ProductsControllerDecorator
        def create
          authorize! :create, ::Spree::Product
          params[:product][:available_on] ||= Time.current
          set_up_shipping_category

          options = {variants_attrs: variants_params, options_attrs: option_types_params}
          @product = ::Spree::Core::Importer::Product.new(nil, product_params, options).create

          if @product.persisted?
            save_properties
            save_images
            save_taxons
            respond_with(@product, status: 201, default_template: :show)
          else
            invalid_resource!(@product)
          end
        end

        def update
          authorize! :update, @product

          options = { variants_attrs: variants_params, options_attrs: option_types_params }
          @product = ::Spree::Core::Importer::Product.new(@product, product_params, options).update

          if @product.errors.empty?
            save_properties
            save_images
            save_taxons
            respond_with(@product.reload, status: 200, default_template: :show)
          else
            invalid_resource!(@product)
          end
        end

        def save_properties
          if params.key? :product_properties
            params[:product_properties].each do |name, value|
              product_property = @product.product_properties.includes(:property).where(spree_properties: {name: name}).first
              unless product_property.nil?
                product_property.update({value: value})
              end
            end
          end
        end

        def save_images
          if params.key? :images
            params[:images].each do |image|
              url = URI.parse(image)
              filename = File.basename(url.path)
              file = URI.open(image)
              attachment = {io: file, :filename => filename, :content_type => file.content_type_parse.first}
              ::Spree::Image.create(:attachment => attachment, :viewable => @product.master)
            end
          end
        end

        def save_taxons
          if params.key? :taxons
            taxon_ids = []
            params[:taxons].each do |taxon_tree|
              taxons = taxon_tree.split('>')
              taxonomy_name = taxons.shift
              taxonomy = ::Spree::Taxonomy.accessible_by(current_ability, :show).where({name: taxonomy_name}).first
              parent_id = taxonomy.root.id
              taxons.each do |taxon_name|
                taxon = taxonomy.taxons.accessible_by(current_ability, :show).where({name: taxon_name, parent_id: parent_id}).first
                if taxon.nil?
                  taxon = ::Spree::Taxon.new({name: taxon_name, parent_id: parent_id, taxonomy_id: taxonomy.id})
                  taxon.save
                end
                # Rails.logger.debug("#{taxon_name} #{parent_id} #{taxon.inspect}")
                taxon_ids << taxon.id
                parent_id = taxon.id
              end
            end
            @product = ::Spree::Core::Importer::Product.new(@product, {taxon_ids: taxon_ids}).update
          end
        end
      end
    end
  end
end


Spree::Api::V1::ProductsController.prepend Spree::Api::V1::ProductsControllerDecorator
