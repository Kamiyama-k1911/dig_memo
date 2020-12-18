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
FactoryBot.define do
  factory :article do
    title { Faker::Lorem.word }
    user
  end

  factory :satoshi_article_1, class: "Article" do
    title { "ポケモン" }
    user_id { 1 }
  end

  factory :satoshi_article_2, class: "Article" do
    title { "デジモン" }
    user_id { 1 }
  end

  # アクセス制限で使う
  factory :takeshi_article, class: "Article" do
    id { 1 }
    title { Faker::Lorem.word }
    association :user, factory: :takeshi
  end
end
