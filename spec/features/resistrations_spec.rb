require "rails_helper"

RSpec.describe "Resistrations", type: :feature do
  it "新規登録する" do
    visit new_user_registration_path

    fill_in "ユーザー名", with: "satoshi"
    fill_in "メールアドレス", with: "satoshi@example.com"
    fill_in "パスワード", with: "satoshi1200"
    fill_in "パスワード確認", with: "satoshi1200"

    click_on "登録する"

    expect(page).to have_content "Welcome! You have signed up successfully."
  end
end
