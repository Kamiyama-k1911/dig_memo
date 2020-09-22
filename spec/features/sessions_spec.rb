require "rails_helper"

RSpec.describe "Sessions", type: :feature do
  describe "ログインした時の操作" do
    before do
      create(:satoshi)
      visit new_user_session_path

      fill_in "メールアドレス", with: "satoshi@example.com"
      fill_in "パスワード", with: "satoshi1290"
      click_button "ログイン"
    end

    it "ログインできる" do
      expect(page).to have_content "ログインしました。"
      expect(page).to have_current_path articles_path, ignore_query: true
    end

    it "ログアウトできる" do
      click_on "ログアウト"
      expect(page).to have_content "ログアウトしました。"
      expect(page).to have_current_path root_path, ignore_query: true
    end
  end

  describe "ログインしていない時の操作" do
    before do
      visit articles_path
    end

    it "ログインしていない状態で記事一覧を見ようとする" do
      expect(page).to have_content "アカウント登録もしくはログインしてください。"
    end

    it "メールアドレスとパスワードが入力されていなかった場合エラーが出る" do
      click_button "ログイン"

      expect(page).to have_content "メールアドレスまたはパスワードが違います。"
    end
  end
end
