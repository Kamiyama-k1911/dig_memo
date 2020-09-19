# == Schema Information
#
# Table name: article_items
#
#  id         :bigint           not null, primary key
#  body       :text
#  question   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :bigint
#
# Indexes
#
#  index_article_items_on_article_id  (article_id)
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#
class ArticleItem < ApplicationRecord
  enum question: {
    why: 0,
    how: 1,
    who: 2,
    where: 3,
    what: 4,
    summary: 5,
    application: 6,
    other: 7,
  }, _prefix: true
  belongs_to :article
end
