class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @articles = current_user.articles.where(favorite: true).page(params[:page]).per(10)
  end

  def update
    @article = Article.find(params[:article_id])

    if @article.favorite == false
      @article.update!(favorite: true)
    else
      @article.update!(favorite: false)
    end

    redirect_back(fallback_location: root_path)
  end
end
