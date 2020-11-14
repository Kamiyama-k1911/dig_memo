class CategoriesController < ApplicationController
  before_action :set_categories

  def index
    @articles = current_user.articles.where(category_id: params[:category_id]).page(params[:page]).per(10)
  end

  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.build(category_param)
    if @category.save
      # redirect_to articles_path
      respond_to do |format|
        format.js { flash.now[:notice] = "カテゴリー : #{@category.name}を新規作成しました！" }
      end
    end
  end

  def edit
  end

  def destroy
    @category = current_user.categories.find(params[:category][:id])

    @category.destroy!
    respond_to do |format|
      format.js { flash.now[:alert] = "カテゴリー : #{@category.name}を削除しました！" }
    end
    # flash[:alert] = "カテゴリーを削除しました！"
    # redirect_to articles_path
  end

  private

    def category_param
      params.permit(:name, :user_id)
    end
end
