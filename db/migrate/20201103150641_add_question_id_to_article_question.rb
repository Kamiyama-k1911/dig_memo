class AddQuestionIdToArticleQuestion < ActiveRecord::Migration[6.0]
  def change
    add_reference :article_items, :article_question, null: false, foreign_key: true
  end
end
