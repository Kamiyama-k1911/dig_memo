# == Schema Information
#
# Table name: articles
#
#  id          :bigint           not null, primary key
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
    user
    category
  end

  factory :satoshi_article_1, class: "Article" do
    title { "ポケモン" }
    user { 1 }
    category
  end

  factory :satoshi_article_2, class: "Article" do
    title { "デジモン" }
    user { 1 }
    category
  end

  # アクセス制限で使う
  factory :takeshi_article, class: "Article" do
    id { 1 }
    title { Faker::Lorem.word }
    association :user, factory: :takeshi
    category
  end

  # カテゴリー分けで使う
  factory :learn_article, class: "Article" do
    title { "学び！" }
    association :user, factory: :satoshi
    category
  end

  factory :impression_article, class: "Article" do
    title { "感想！" }
    association :user, factory: :satoshi
    category
  end

  factory :answer_article, class: "Article" do
    title { "質問への回答！" }
    association :user, factory: :satoshi
    category
  end

  factory :other_article, class: "Article" do
    title { "その他！" }
    association :user, factory: :satoshi
    category
  end
end
