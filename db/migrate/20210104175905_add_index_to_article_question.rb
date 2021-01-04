class AddIndexToArticleQuestion < ActiveRecord::Migration[6.0]
  def change
    add_index :article_questions, [:question, :user_id], unique: true
  end
end
