class ProductsController < APIController
  before_action :authenticate_user!

  def index
    offset = params[:offset].to_i
    prods = Product.limit(limit).offset(offset).order(:id)
    response = {
      products: prods.map { |prod| prod.product_json } ,
      product_count: Product.count
    }
    render_success(response)
  end

  private

  def limit
    if params[:limit].present?
      [params[:limit].to_i, Product::DEFAULT_LIMIT].min
    else
      Product::DEFAULT_LIMIT
    end
  end
end
