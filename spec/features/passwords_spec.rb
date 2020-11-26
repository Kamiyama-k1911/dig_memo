require "rails_helper"

RSpec.describe "Passwords", type: :feature do
  describe "正常系" do
    let!(:user) { create(:user) }
    # let!(:confirmation_token) { user.confirmation_token }

    it "パスワード再設定メールが送信される" do
      visit new_user_password_path

      fill_in "メールアドレス", with: user.email
      expect { click_on "送信する" }.to change { ActionMailer::Base.deliveries.size }.by(1)
    end
  end

  #   it "パスワード変更ができる" do
  #     #パスワード変更するためのページへ
  #     visit new_user_password_path

  #     fill_in "メールアドレス", with: user.email

  #     #クリックすることで、入力したメールアドレスのユーザーに対して、パスワードリセットトークンが発行される
  #     click_on "送信する"

  #     #一番最近パスワードリセットトークンを発行したユーザーを取得する
  #     change_password_user = User.order(reset_password_sent_at: :desc).limit(1)
  #     reset_password_token = change_password_user[0].reset_password_token

  #     #新しいパスワードを設定するページに取得したパスワードリセットトークンを持たせて移動する

  #     visit Rails.application.routes.url_helpers.edit_user_password_url(change_password_user,reset_password_token: reset_password_token)

  #     expect(page).to have_current_path Rails.application.routes.url_helpers.edit_user_password_url(change_password_user), ignore_query: true
  #     binding.pry
  #     #新しいパスワードを入力する
  #     fill_in "新しいパスワード(8文字以上)", with: "newpassword1299"
  #     fill_in "パスワード確認", with: "newpassword1299"

  #     click_on "パスワードを変更する"

  #     #パスワード変更完了のフラッシュメッセージが出ているか確かめる
  #     expect(page).to have_content "パスワードが正しく変更されました。"
  #     #ログインして、記事一覧ページに飛べているかを確かめる
  #     expect(page).to have_current_path articles_path, ignore_query: true
  #   end

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
