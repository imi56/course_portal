class BaseAPIController < ApplicationController
  require 'jwt_auth_token'
  require 'exceptions'
  # When an error occurs, respond with the proper private method below
  rescue_from Exceptions::AuthenticationTimeoutError, with: :authentication_timeout_handler
  rescue_from Exceptions::NotAuthenticatedError, with: :user_not_authenticated_handler
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record_handler
  rescue_from ActiveRecord::InvalidForeignKey, with: :foreign_key_constraint_handler

  def validate_params
    @token ||= if request.headers['Authorization'].present?
      request.headers['Authorization'].split(' ').last
    end

    unless @token.present? && decoded_token.present? && decoded_token[:id].present?
      raise Exceptions::NotAuthenticatedError
    end
    dt = decoded_token
  end

  def decoded_token
    @decoded_token ||= JwtAuthToken.decode(@token, leeway = 2.minutes)
  end

  def authentication_timeout_handler
    render json: {result: 'failed', messages: ['Token Expired']}, status: 419
  end

  def user_not_authenticated_handler
    render json: {result: 'failed', messages: ['Authorization Failed']}, status: :unauthorized
  end

  def permisson_denied_handler
    render json: {result: 'failed', messages: ['Permission Denied']}, status: :unauthorized
  end

  def invalid_record_handler(e)
    render_error(e.record.errors.full_messages)
  end

  def foreign_key_constraint_handler
    render_error(["This record is associated with some other record, can't be deleted"])
  end

end
