# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe Category, type: :model do
  context "カテゴリーの名前が空の時" do
    let!(:category) { build(:category, name: nil) }

    it "カテゴリーを作成できない" do
      expect(category).to be_invalid
    end
  end

  context "カテゴリーの名前が空じゃない時" do
    let!(:category) { build(:category) }

    it "カテゴリー作成ができる" do
      expect(category).to be_valid
    end
  end
end
