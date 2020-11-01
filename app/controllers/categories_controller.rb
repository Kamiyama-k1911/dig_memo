class CategoriesController < ApplicationController
  def index
    @articles = Article.where(category_id: params[:category_id]).page(params[:page]).per(10)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_param)
    if @category.save
      flash[:notice] = "カテゴリーを新規作成しました！"
      redirect_to articles_path
    else
      render :new
    end
  end

  def edit
  end

  def destroy
    @category = Category.find(params[:category][:id])

    @category.destroy!
    flash[:alert] = "カテゴリーを削除しました！"
    redirect_to articles_path
  end

  private

    def category_param
      params.permit(:name)
    end
end
