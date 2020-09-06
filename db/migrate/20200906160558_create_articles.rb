class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body1
      t.text :body2
      t.text :body3
      t.text :body4
      t.text :body5
      t.text :body6
      t.text :body7

      t.references :user, null: false, foreign_key: true
      t.references :category, foreign_key: true
      t.timestamps
    end
  end
end
