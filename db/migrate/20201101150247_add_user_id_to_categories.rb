class AddUserIdToCategories < ActiveRecord::Migration[6.0]
  def up
    add_reference :categories, :user, foreign_key: true
    change_column_null :categories, :user_id, false
  end
end
