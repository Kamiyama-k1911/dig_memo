class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.boolean :favorite, default: false, null: false

      t.references :user, null: false, foreign_key: true
      t.references :category, foreign_key: true
      t.timestamps
    end
  end
end
