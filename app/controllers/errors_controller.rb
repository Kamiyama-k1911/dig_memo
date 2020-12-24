class ErrorsController < ApplicationController
  def not_found
    redirect_back(fallback_location: root_path)
  end

  def unprocessable_entity
    render status: 422
  end

  def internal_server_error
    redirect_back(fallback_location: root_path)
  end
end
