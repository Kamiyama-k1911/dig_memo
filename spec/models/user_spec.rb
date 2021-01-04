# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  unconfirmed_email      :string(255)
#  username               :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require "rails_helper"

RSpec.describe User, type: :model do
  let!(:user) { build(:user) }

  describe "正常系" do
    context "ユーザーデータが全て入力されていた時" do
      it "ユーザーデータ登録に成功する" do
        expect(user).to be_valid
      end
    end

    context "パスワードに小文字と数字が含まれ、文字数が8~32文字だった時" do
      it "ユーザーデータ登録に成功する" do
        user.password = "1234abcd"
        expect(user).to be_valid
      end
    end

    context "正しいメールアドレスが入力された時" do
      it "ユーザーデータ登録に成功する" do
        user.password = "1234abcd@example.com"
        expect(user).to be_valid
      end
    end
  end

  describe "異常系" do
    context "ユーザーの名前が空の時" do
      it "ユーザーデータ登録に失敗する" do
        user.username = nil

        expect(user).to be_invalid
        expect(user.errors.details[:username][0][:error]).to eq :blank
      end
    end

    context "メールアドレスが空の時" do
      it "ユーザーデータ登録に失敗する" do
        user.email = nil
        expect(user).to be_invalid
      end
    end

    context "メールアドレスに@が含まれなかった時" do
      it "ユーザーデータ登録に失敗する" do
        user.email = "1234example.com"
        expect(user).to be_invalid
      end
    end

    context "メールアドレスに.が含まれなかった時" do
      it "ユーザーデータ登録に失敗する" do
        user.email = "1234@examplecom"
        expect(user).to be_invalid
      end
    end

    context "メールアドレスが@から始まった時" do
      it "ユーザーデータ登録に失敗する" do
        user.email = "@1234@example.com"
        expect(user).to be_invalid
      end
    end

    context "既に同じメールアドレスが存在していた時" do
      before { create(:user, email: "tarotaro@example.com") }

      it "ユーザーデータ登録に失敗する" do
        user.email = "tarotaro@example.com"

        expect(user).to be_invalid
        expect(user.errors.details[:email][0][:error]).to eq :taken
      end
    end

    context "パスワードが空の時" do
      it "ユーザーデータ登録に失敗する" do
        user.password = nil
        expect(user).to be_invalid
      end
    end

    context "パスワードが7文字だった時" do
      it "ユーザーデータ登録に失敗する" do
        user.password = "abcd123"
        expect(user).to be_invalid
      end
    end

    context "パスワードが33文字だった時" do
      it "ユーザーデータ登録に失敗する" do
        user.password = "a1" * 16 + "a"
        expect(user).to be_invalid
      end
    end

    context "パスワードが文字だけだった時" do
      it "ユーザーデータ登録に失敗する" do
        user.password = "a" * 8
        expect(user).to be_invalid
      end
    end

    context "パスワードが数字だけだった時" do
      it "ユーザーデータ登録に失敗する" do
        user.password = 11_111_111
        expect(user).to be_invalid
      end
    end
  end
end
