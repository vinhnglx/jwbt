module V1::Product::Parameter
  extend ActiveSupport::Concern

  private

    # Product parameters
    #
    # @returns Hash
    def product_params
      params.require(:product).permit(:name, :price)
    end
end
