module Spree
  module Admin
    class SupplierImagesController < ResourceController
      before_action :load_edit_data, except: :index
      before_action :load_index_data, only: :index

      create.before :set_viewable
      update.before :set_viewable

      private

      def location_after_destroy
        admin_supplier_supplier_images_url(@supplier)
      end

      def location_after_save
        admin_supplier_supplier_images_url(@supplier)
      end

      def load_index_data
        #@product = Product.friendly.includes(*variant_index_includes).find(params[:product_id])
        @supplier = Supplier.friendly.find(params[:supplier_id])
      end

      def load_edit_data
        #@product = Product.friendly.includes(*variant_edit_includes).find(params[:product_id])
        #@variants = @product.variants.map do |variant|
        #  [variant.sku_and_options_text, variant.id]
        #end
        #@variants.insert(0, [Spree.t(:all), @product.master.id])
        @supplier = Supplier.friendly.find(params[:supplier_id])
      end

      def set_viewable
        byebug
        @supplier_image.viewable_type = 'Spree::Supplier'
        @supplier_image.viewable_id = params[:supplier_image][:viewable_id]
      end

      def variant_index_includes
        [
          variant_images: [viewable: { option_values: :option_type }]
        ]
      end

      def variant_edit_includes
        [
          variants_including_master: { option_values: :option_type, images: :viewable }
        ]
      end
    end
  end
end
