# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :category do
    name { nil }
  end

  factory :learn, class: "Category" do
    id { 1 }
    name { "学び" }
  end

  factory :impression, class: "Category" do
    id { 2 }
    name { "感想" }
  end

  factory :answer, class: "Category" do
    id { 3 }
    name { "質問への回答" }
  end

  factory :other, class: "Category" do
    id { 4 }
    name { "その他" }
  end
end
