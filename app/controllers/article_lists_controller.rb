class ArticleListsController < ApplicationController
  before_action :authenticate_user!

  def plus
    @article_questions = current_user.article_questions
  end

  def minus
    # メモ編集画面でメモの内容を削除する
    if params[:item_id]
      @article_item = ArticleItem.find(params[:item_id])
      @article_item.destroy!
    end
  end
end
