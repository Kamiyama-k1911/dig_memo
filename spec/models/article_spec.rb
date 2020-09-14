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
require "rails_helper"

RSpec.describe Article, type: :model do
  context "タイトルと内容1が入力されていた時" do
    it "記事投稿に成功する" do
      article = build(:article)

      expect(article).to be_valid
    end
  end

  context "タイトルが空だった時" do
    it "記事投稿に失敗する" do
      article = build(:article, title: nil)

      expect(article).to be_invalid
    end
  end

  context "内容1が空だった時" do
    it "記事投稿に失敗する" do
      article = build(:article, body1: nil)

      expect(article).to be_invalid
    end
  end
end
