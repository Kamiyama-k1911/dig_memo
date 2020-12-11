class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  def check_guest
    email = resource&.email || params[:user][:email].downcase
    if email == "guest@example.com"
      redirect_to root_path
      flash[:alert] = "ゲストユーザーの編集・削除はできません！"
    end
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username])
    end

  private

    def set_categories
      @categories = current_user.categories
    end
end
