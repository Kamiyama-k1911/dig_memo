# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  unconfirmed_email      :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require "rails_helper"

RSpec.describe User, type: :model do
  context "ユーザーデータが全て入力されていた時" do
    it "ユーザーデータ登録に成功する" do
      user = build(:user)

      expect(user).to be_valid
    end
  end

  context "ユーザーの名前が空の時" do
    it "ユーザーデータ登録に失敗する" do
      user = build(:user, username: nil)

      expect(user).to be_invalid
      expect(user.errors.details[:username][0][:error]).to eq :blank
    end
  end

  context "メールアドレスが空の時" do
    it "ユーザーデータ登録に失敗する" do
      user = build(:user, email: nil)
      expect(user).to be_invalid
    end
  end

  context "既に同じメールアドレスが存在していた時" do
    before { create(:user, email: "tarotaro@example.com") }

    it "ユーザーデータ登録に失敗する" do
      user = build(:user, email: "tarotaro@example.com")

      expect(user).to be_invalid
      expect(user.errors.details[:email][0][:error]).to eq :taken
    end
  end

  context "パスワードが空の時" do
    it "ユーザーデータ登録に失敗する" do
      user = build(:user, password: nil)
      expect(user).to be_invalid
    end
  end
end
