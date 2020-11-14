class ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_categories

  def index
    @articles = current_user.articles.all.page(params[:page]).per(10)
  end

  def new
    @article = Article.new
    @article_item = ArticleItem.new
    @article_questions = current_user.article_questions
  end

  def create
    @article = current_user.articles.build(article_params)

    if @article.save
      params[:items].each do |item|
        @article_item = @article.article_items.build(article_question_id: item[1][0], body: item[1][1])
        @article_item.save
      end
      flash[:notice] = "新規投稿しました！"
      redirect_to articles_path
    else
      render :new
      flash.now[:notice] = "問いと内容を入力してください！"
    end
  end

  def show
    @article = Article.find(params[:id])
    @article_questions = current_user.article_questions

    if @article.user != current_user
      flash[:alert] = "他のユーザーの投稿を見ることはできません！"
      redirect_to articles_path
    end
  end

  def edit
    @article = Article.find(params[:id])
    @article_items = @article.article_items
    @article_questions = current_user.article_questions

    if @article.user != current_user
      flash[:alert] = "他のユーザーの投稿は編集できません！"
      redirect_to articles_path
    end
  end

  def update
    @article = Article.find(params[:id])
    @article_items = @article.article_items

    if @article.update(update_article_params)
      # if params.include?("items") タイトルだけのメモの編集でタイトルだけを編集した場合に出るエラー対策
      if params.include?("items")
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

  def article_item_destroy
    @article = Article.find(params[:id])
    @article_items = @article.article_items

    @article_items.last.destroy!
  end

  def search
    @articles = current_user.articles.search(params[:search_word])
  end

  private

    def article_params
      params.require(:article).permit(:title, :category_id, :user_id)
    end

    def article_item_params
      params.require(:items).permit(:item1, :item2, :item3, :item4, :item5, :item6, :item7)
    end

    def update_article_params
      params.require(:article).permit(:title, :category_id)
    end
end
