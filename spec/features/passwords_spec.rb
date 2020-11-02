require "rails_helper"

# RSpec.fdescribe "Passwords", js: true, type: :feature do
# let!(:user) { create(:user) }
# let!(:confirmation_token) { user.confirmation_token }

# before do
#   #アカウントを有効化するURL
#   visit user_confirmation_path(confirmation_token: confirmation_token)

#   #ユーザー登録が完了した後、自動的にログインするように設定しているため、一旦ログアウト
#   accept_confirm do
#     click_on "ログアウト"
#   end
# end

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

#     binding.pry

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
# end
