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
FactoryBot.define do
  factory :article_item do
    title { "MyString" }
    body { "MyText" }
  end
end
