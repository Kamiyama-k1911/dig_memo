class CreateArticleItems < ActiveRecord::Migration[6.0]
  def change
    create_table :article_items do |t|
      t.text :body
      t.references :article, foreign_key: true

      t.timestamps
    end
  end
end
