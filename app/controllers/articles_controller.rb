class ArticlesController < ApplicationController
  before_action :set_article, only: [:update, :destroy, :article_item_destroy]
  before_action :set_article_questions, only: [:show, :edit]
  before_action :browser_rimit, only: [:show, :edit]

  def index
    @articles = current_user.articles.all.page(params[:page]).per(10)
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)

    if @article.save
      article_item_create

      flash[:notice] = "新規投稿しました！"
      redirect_to articles_path
    else
      respond_to do |format|
        format.js { flash.now[:alert] = "タイトルを入力してください！" }
      end
    end
  end

  def show
  end

  def edit
    @article_items = @article.article_items
  end

  def update
    @article_items = @article.article_items
    if @article.update(update_article_params)
      article_item_edit

      flash[:notice] = "投稿を編集しました！"
      redirect_to articles_path
    else
      respond_to do |format|
        format.js { flash.now[:alert] = "タイトルを入力してください！" }
      end
    end
  end

  def destroy
    @article.destroy!
    flash[:alert] = "投稿を削除しました！"
    redirect_to articles_path
  end

  def article_item_destroy
    @article_items = @article.article_items

    @article_items.last.destroy!
  end

  def search
    @search_word = params[:search_word]
    articles = current_user.articles

    @inner_join = articles.joins(:article_items).select('articles.*, article_items.body')
    @search_result = @inner_join.where(["title LIKE ?", "%#{@search_word}%"]).or(@inner_join.where(["body LIKE ?", "%#{@search_word}%"])).page(params[:page]).per(10)
  end

  private

    def article_item_create
      params[:items].each do |item|
        @article_item = @article.article_items.build(article_question_id: item[1][0], body: item[1][1])
        @article_item.save!
      end
    end

    def article_item_edit
      return unless params.include?("items")

      i = 0
      params[:items].each do |item|
        if @article_items.length < i + 1
          @article_items.create!(article_question_id: item[1][0], body: item[1][1])
        else
          @article_items[i].update!(article_question_id: item[1][0], body: item[1][1])
        end
        i += 1
      end
    end

    def browser_rimit
      @article = Article.find(params[:id])

      if @article.user != current_user
        flash[:alert] = "他のユーザーの投稿の閲覧・編集はできません！"
        redirect_to articles_path
      end
    end

    def set_article_questions
      @article_questions = current_user.article_questions
    end

    def set_article
      @article = current_user.articles.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :category_id, :user_id)
    end

    def update_article_params
      params.require(:article).permit(:title, :category_id)
    end
end
