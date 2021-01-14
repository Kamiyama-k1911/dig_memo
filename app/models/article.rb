# == Schema Information
#
# Table name: articles
#
#  id          :bigint           not null, primary key
#  favorite    :boolean          default(FALSE), not null
#  title       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint
#  user_id     :bigint           not null
#
# Indexes
#
#  index_articles_on_category_id  (category_id)
#  index_articles_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#
class Article < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  has_many :article_items, dependent: :destroy

  validates :title, presence: true

  def self.search(search, joins_model)
    if search
      joins_model.where(["title LIKE ?", "%#{search}%"]).or(joins_model.where(["body LIKE ?", "%#{search}%"]))
    end
  end
end
