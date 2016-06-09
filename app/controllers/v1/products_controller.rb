class V1::ProductsController < V1::BaseController
  include ::V1::Product::Parameter

  def index
    @products = Product.all
    render json: @products, status: :ok
  end

  def create
    product = Product.new(product_params)

    return head :internal_server_error unless product.valid?

    render json: product, status: :created if product.save!
  end
end
