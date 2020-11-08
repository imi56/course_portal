class RatingsController < APIController
  before_action :authenticate_user!
  before_action :find_product

  def create
    rating = Rating.find_or_initialize_by(id: params[:id].to_i)
    rating.user_id = current_user.id
    rating.assign_attributes(create_params)
    if rating.valid?
      rating.save!
      render_success(@prod.reload.product_json_for(current_user))
    else
      render_error(rating.errors.full_messages)
    end
  end

  private

  def create_params
    params.permit(:id, :product_id, :rating)
  end

  def find_product
    @prod = Product.find_by(id: create_params[:product_id])
    render_error(["No such product exists"]) and return if @prod.nil?
  end

end