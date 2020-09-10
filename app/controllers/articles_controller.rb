class ArticlesController < ApplicationController
  def index
    @articles = current_user.articles.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)

    if @article.save
      binding.pry
      flash[:notice] = "新規投稿しました！"
      redirect_to articles_path
    else
      binding.pry
      render :new
    end
  end

  def show
  end

  def edit
  end

  private

  def article_params
    params.require(:article).permit(:title, :body1, :body2, :body3, :body4, :body5, :body6, :body7,:category_id,:user_id)
  end
end
