class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :set_categories

  def index
    # ログインしている時ホーム画面に行けないようにする
    unless current_user.nil?
      redirect_to articles_path
    end
  end
end
