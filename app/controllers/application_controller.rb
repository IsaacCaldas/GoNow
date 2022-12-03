class ApplicationController < ActionController::Base

  def index 
    render json: {
      status: 'ok', 
      live_time: {
        server_time: Time.now, 
        server_timestamp: Time.now.to_i
      }
    }
  end
end
