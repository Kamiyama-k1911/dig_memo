# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_categories_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :category do
    name { Faker::Lorem.word }
    user
  end

  factory :sample, class: "Category" do
    name { "サンプル" }
  end

  factory :sample2, class: "Category" do
    name { "サンプル2" }
  end

end
