require "rails_helper"

RSpec.describe "Sessions", type: :feature do
  describe "正常系" do
    context "ログインした時の操作" do
      let!(:user) { create(:user) }
      before do
        token = user.confirmation_token

        visit user_confirmation_path(confirmation_token: token)

        # 認証された後、ログインされるようになっているためログアウト
        click_on "ログアウト"

        visit new_user_session_path

        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: user.password
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

    context "ログインしていない時" do
      it "ゲストログインに成功する" do
        visit root_path
        click_on "ゲストログイン（閲覧用）"

        expect(page).to have_content "ゲストユーザーとしてログインしました。"
      end
    end
  end

  describe "異常系" do
    it "記事一覧をみようとした時、みることができない" do
      visit articles_path
      expect(page).to have_content "アカウント登録もしくはログインしてください。"
    end

    it "メールアドレスとパスワードが入力されていなかった場合、ログインできない" do
      visit new_user_session_path
      click_button "ログイン"

      expect(page).to have_content "メールアドレスまたはパスワードが違います。"
    end
  end
end
