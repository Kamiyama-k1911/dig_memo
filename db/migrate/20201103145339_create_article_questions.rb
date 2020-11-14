class CreateArticleQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :article_questions do |t|
      t.string :question
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
