class CategoriesController < ApplicationController
  def index
    @articles = if params[:category_id].to_i == 1
                  current_user.articles.where(category_id: 1)
                elsif params[:category_id].to_i == 2
                  current_user.articles.where(category_id: 2)
                elsif params[:category_id].to_i == 3
                  current_user.articles.where(category_id: 3)
                else
                  current_user.articles.where(category_id: 4)
                end
  end
end
