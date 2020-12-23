require "rails_helper"

RSpec.describe "Passwords", js: true, type: :feature do
  describe "正常系" do
    let!(:user) { create(:user) }
    # let!(:confirmation_token) { user.confirmation_token }

    it "パスワード再設定メールが送信される" do
      visit new_user_password_path

      fill_in "メールアドレス", with: user.email
      expect { click_on "送信する" }.to change { ActionMailer::Base.deliveries.size }.by(1)
    end
  end

  describe "異常系" do
    context "password/newのフォームに入力されたメールアドレスがゲストユーザーの物だった時" do
      let(:guest_address) { "guest@example.com" }

      it "警告のフラッシュメッセージが表示され、ホーム画面に戻る" do
        visit new_user_password_path

        fill_in "メールアドレス", with: guest_address
        click_on "送信する"

        expect(page).to have_content "ゲストユーザーの編集・削除はできません！"
        expect(page).to have_current_path root_path, ignore_query: true
      end
    end
  end
end
