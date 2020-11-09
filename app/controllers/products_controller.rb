class ProductsController < APIController
  before_action :authenticate_user!

  def index
    offset = params[:offset].to_i
    prods = Product.filters(filter_params).limit(limit).offset(offset).order(:id)
    response = {
      products: prods.map { |prod| prod.product_json_for(current_user) } ,
      product_count: Product.count
    }
    render_success(response)
  end

  private


  def filter_params
    params.slice(:type, :provider)
  end

  def limit
    if params[:limit].present?
      [params[:limit].to_i, Product::DEFAULT_LIMIT].min
    else
      Product::DEFAULT_LIMIT
    end
  end
end
