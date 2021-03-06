# == Schema Information
#
# Table name: article_questions
#
#  id         :bigint           not null, primary key
#  question   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_article_questions_on_question_and_user_id  (question,user_id) UNIQUE
#  index_article_questions_on_user_id               (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class ArticleQuestion < ApplicationRecord
  belongs_to :user
  has_many :article_items, dependent: :nullify

  validates :question, presence: true, uniqueness: { scope: :user_id }
end
