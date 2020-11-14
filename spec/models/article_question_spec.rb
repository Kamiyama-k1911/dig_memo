# == Schema Information
#
# Table name: article_questions
#
#  id         :bigint           not null, primary key
#  question   :string
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
require "rails_helper"

RSpec.describe ArticleQuestion, type: :model do
  context "カテゴリーの名前が空の時" do
    let!(:article_question) { build(:article_question, question: nil) }

    it "カテゴリーを作成できない" do
      expect(article_question).to be_invalid
    end
  end

  context "カテゴリーの名前が空じゃない時" do
    let!(:article_question) { build(:article_question) }

    it "カテゴリー作成ができる" do
      expect(article_question).to be_valid
    end
  end
end
