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
#  index_article_questions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :article_question, class: "ArticleQuestion" do
    question { Faker::Lorem.word }
    user
  end

  factory :question_why, class: "ArticleQuestion" do
    question { "なぜ？" }
    user_id { 1 }
  end

  factory :question_where, class: "ArticleQuestion" do
    question { "どこで？" }
    user_id { 1 }
  end
end
