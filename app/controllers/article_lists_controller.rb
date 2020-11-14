class ArticleListsController < ApplicationController
  def plus
    @article_questions = current_user.article_questions
  end

  def minus
    @article_item = ArticleItem.find(params[:item_id])
    @article_item.destroy!
  end
end
