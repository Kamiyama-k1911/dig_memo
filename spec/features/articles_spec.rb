require "rails_helper"

RSpec.describe "Articles", type: :feature do
  before do
    create(:satoshi)
    create(:learn)
    create(:impression)
    create(:answer)
    create(:other)
  end

  it "新規投稿する" do
    visit new_user_session_path

    fill_in "メールアドレス", with: "satoshi@example.com"
    fill_in "パスワード", with: "satoshi1290"
    click_button "ログイン"

    visit new_article_path

    select "その他", from: "article[category_id]"
    fill_in "タイトル", with: "こんにちは"
    fill_in "内容1", with: "よろしくお願いします"

    click_button "投稿する"

    expect(page).to have_content "こんにちは"
    expect(page).to have_current_path articles_path, ignore_query: true
  end
end
