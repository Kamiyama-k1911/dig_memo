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
end
