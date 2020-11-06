class ApplicationController < ActionController::API
  # protect_from_forgery with: :exception
  def render_error(messages = [], result = :failed, status = :bad_request)
    render json: { result: result, messages: messages }, status: status
  end

  #  res => data, status, result, messages
  def render_success(data = {}, messages = ['Success'], status = :ok)
    render json: { data: data, result: :success, messages: messages }, status: status
  end

  def api
    render json: { message: 'You explored an API' }, status: :ok
  end

  def current_time
    Time.zone.now
  end
end
