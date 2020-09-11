# == Schema Information
#
# Table name: articles
#
#  id          :bigint           not null, primary key
#  body1       :text
#  body2       :text
#  body3       :text
#  body4       :text
#  body5       :text
#  body6       :text
#  body7       :text
#  title       :string
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
FactoryBot.define do
  factory :article do
    title { Faker::Lorem.word }
    body1 { Faker::Lorem.sentence }
    user
    category
  end

  # アクセス制限で使う
  factory :takeshi_article, class: "Article" do
    id { 1 }
    title { Faker::Lorem.word }
    body1 { Faker::Lorem.sentence }
    association :user, factory: :takeshi
    category
  end

  # カテゴリー分けで使う
  factory :learn_article, class: "Article" do
    title { "学び！" }
    body1 { "学び" }
    association :user, factory: :satoshi
    category
  end

  factory :impression_article, class: "Article" do
    title { "感想！" }
    body1 { "感想" }
    association :user, factory: :satoshi
    category
  end

  factory :answer_article, class: "Article" do
    title { "質問への回答！" }
    body1 { "質問への回答" }
    association :user, factory: :satoshi
    category
  end

  factory :other_article, class: "Article" do
    title { "その他！" }
    body1 { "その他" }
    association :user, factory: :satoshi
    category
  end
end
