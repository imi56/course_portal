class AuthenticationController < APIController
  require 'jwt_auth_token'
  attr_reader :user
  before_action :verify_otp, only: [:login, :sign_up]
  before_action :find_user, only: [:login, :sign_up]

  def sign_up
    render_error( ['Phone already registered, please login']) and return if user.present?
    user = User.new(user_params)
    if user.save
      deleteOtp(params[:phone])
      render json: { data: get_token_data({ id: user.id }) }, status: :created
    else
      render_error(user.errors.full_messages)
    end
  end

  def login
    render_error( ['Phone not registered, please sign up']) and return if user.blank?
    deleteOtp(params[:phone])
    render json: { data: get_token_data({ id: user.id }) }, status: :ok
  end

  private

  def get_token_data(data_to_be_encoded={})
    data = {}
    token = JwtAuthToken.encode(data_to_be_encoded)
    data[:auth_token] = token
    data[:expiry] = JwtAuthToken::Constants::DEFAULT_TTL
    data
  end

  def verify_otp
      render_error(['Invalid OTP']) and return unless Otp.verify(params[:phone], params[:otp])
  end

  def find_user
    @user = User.find_by(phone: params[:phone])
  end

  def deleteOtp(phone)
    otp = Otp.where(phone: phone)
    otp.destroy_all if otp.present?
  end

  def user_params
    params.permit( :name, :phone)
  end
end
