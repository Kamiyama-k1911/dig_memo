# == Schema Information
#
# Table name: article_items
#
#  id                  :bigint           not null, primary key
#  body                :text(65535)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  article_id          :bigint
#  article_question_id :bigint
#
# Indexes
#
#  index_article_items_on_article_id           (article_id)
#  index_article_items_on_article_question_id  (article_question_id)
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#  fk_rails_...  (article_question_id => article_questions.id)
#
class ArticleItem < ApplicationRecord
  belongs_to :article_question, optional: true
  belongs_to :article

  def self.item_search(search)
    if search
      ArticleItem.where(["body LIKE ?", "%#{search}%"])
      # && Article.where(["title LIKE ?", "%#{search}%"])
    end
  end
end
