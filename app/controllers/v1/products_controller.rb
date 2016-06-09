class V1::ProductsController < V1::BaseController
  include ::V1::Product::Parameter

  def index
    @products = Product.all
    render json: @products, status: :ok
  end

  def create
    product = Product.new(product_params)
    if product.valid?
      product.save!
      render json: product, status: :created
    else
      return head :internal_server_error
    end
  end
end
