class HomeController < ApplicationController
  def index
    # ログインしている時ホーム画面に行けないようにする
    unless current_user.nil?
      redirect_to articles_path
    end
  end
end
