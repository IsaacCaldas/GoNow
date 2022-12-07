class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def index
    render json: {
      status: :ok,
      live_time: {
        server_time: Time.now,
        server_timestamp: Time.now.to_i
      }
    }
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :surname, :email, :username])
  end
end
