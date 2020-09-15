class ArticlesController < ApplicationController
  before_action :authenticate_user!

  def index
    @articles = current_user.articles.all
  end

  def new
    @article = Article.new
    @article_item = ArticleItem.new
  end

  def create
    @article = current_user.articles.build(article_params)
    
    if @article.save
      @article_item = @article.article_items.build(article_item_params[:article_item]) 
      
      if @article_item.save

      flash[:notice] = "新規投稿しました！"
      redirect_to articles_path
      end
    else
      render :new
    end
  end

  def show
    @article = Article.find(params[:id])

    if @article.user != current_user
      flash[:alert] = "他のユーザーの投稿を見ることはできません！"
      redirect_to articles_path
    end
  end

  def edit
    @article = Article.find(params[:id])
    if @article.user != current_user
      flash[:alert] = "他のユーザーの投稿は編集できません！"
      redirect_to articles_path
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(update_article_params)
      flash[:notice] = "投稿を編集しました！"
      redirect_to articles_path
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])

    @article.destroy!
    flash[:alert] = "投稿を削除しました！"
    redirect_to articles_path
  end

  private

    def article_params
      params.require(:article).permit(:title, :category_id, :user_id)
    end

    def article_item_params
      params.require(:article).permit(article_item:[:question, :body])
    end

    def update_article_params
      params.require(:article).permit(:title, :category_id)
    end
end
