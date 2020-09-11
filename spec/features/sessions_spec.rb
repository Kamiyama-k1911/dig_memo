require "rails_helper"

RSpec.describe "Sessions", type: :feature do
  before do
    create(:satoshi)
  end

  it "ログインした後ログアウトする" do
    visit new_user_session_path

    fill_in "メールアドレス", with: "satoshi@example.com"
    fill_in "パスワード", with: "satoshi1290"
    click_button "ログイン"

    expect(page).to have_content "Signed in successfully."

    click_on "ログアウト"

    expect(page).to have_content "Signed out successfully."
  end

  it "ログインしていない状態で記事一覧を見ようとする" do
    visit articles_path

    expect(page).to have_content "You need to sign in or sign up before continuing."
  end
end
