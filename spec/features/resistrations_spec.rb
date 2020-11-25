require "rails_helper"

RSpec.describe "Resistrations", js: true, type: :feature do
  describe "正常系" do
    context "新規登録していない場合" do
      it "新規登録する" do
        visit new_user_registration_path

        fill_in "ユーザー名", with: "satoshi"
        fill_in "メールアドレス", with: "satoshi@example.com"
        fill_in "パスワード", with: "satoshi1200"
        fill_in "パスワード確認", with: "satoshi1200"

        click_on "登録する"

        user = User.last
        token = user.confirmation_token

        visit user_confirmation_path(confirmation_token: token)

        expect(page).to have_content "メールアドレスが確認できました。"
      end
    end

    context "新規登録が済んでいる場合" do
      before do
        visit new_user_registration_path

        fill_in "ユーザー名", with: "satoshi"
        fill_in "メールアドレス", with: "satoshi@example.com"
        fill_in "パスワード", with: "satoshi1200"
        fill_in "パスワード確認", with: "satoshi1200"

        click_on "登録する"

        user = User.last
        token = user.confirmation_token

        visit user_confirmation_path(confirmation_token: token)
      end

      it "アカウント情報を更新できる" do
        visit edit_user_registration_path

        fill_in "ユーザー名", with: "takeshi"
        fill_in "メールアドレス", with: "takeshi@example.com"

        click_on "編集する"

        expect(page).to have_content "アカウント情報を変更しました。"

        visit edit_user_registration_path

        expect(page).to have_field "ユーザー名", with: "takeshi"
        expect(page).to have_field "メールアドレス", with: "takeshi@example.com"
      end

      it "アカウント情報を削除できる" do
        visit edit_user_registration_path

        accept_confirm do
          click_button "アカウントを削除する"
        end

        expect(page).to have_content "アカウントを削除しました。またのご利用をお待ちしております。"
      end
    end
  end

  describe "異常系" do
    context "アカウント登録をしていない場合" do
      it "アカウント情報を編集できない" do
        visit edit_user_registration_path

        expect(page).to have_content "アカウント登録もしくはログインしてください。"
      end
    end

    context "入力されていない項目がある場合" do
      before do
        visit new_user_registration_path
      end

      it "ユーザー名を入力してくださいとエラーが出る" do
        fill_in "ユーザー名", with: nil
        fill_in "メールアドレス", with: "satoshi@example.com"
        fill_in "パスワード", with: "satoshi1200"
        fill_in "パスワード確認", with: "satoshi1200"

        click_on "登録する"

        expect(page).to have_content "ユーザー名を入力してください"
      end

      it "メールアドレスを入力してくださいとエラーが出る" do
        fill_in "ユーザー名", with: "satoshi"
        fill_in "メールアドレス", with: nil
        fill_in "パスワード", with: "satoshi1200"
        fill_in "パスワード確認", with: "satoshi1200"

        click_on "登録する"

        expect(page).to have_content "メールアドレスを入力してください"
      end

      it "パスワードを入力してくださいとエラーが出る" do
        fill_in "ユーザー名", with: "satoshi"
        fill_in "メールアドレス", with: "satoshi@example.com"
        fill_in "パスワード", with: nil
        fill_in "パスワード確認", with: nil

        click_on "登録する"

        expect(page).to have_content "パスワードを入力してください"
      end
    end
  end

  describe "ゲストユーザー" do
    context "ログインしているユーザーがゲストユーザーだった時" do
      before do
        visit root_path
        click_on "ゲストログイン（閲覧用）"
      end

      it "ユーザー情報を変更できない" do
        visit edit_user_registration_path

        click_on "編集する"
        expect(page).to have_content "ゲストユーザーの編集・削除はできません！"
      end

      it "ユーザーを削除できない" do
        visit edit_user_registration_path

        accept_confirm do
          click_on "アカウントを削除する"
        end
        expect(page).to have_content "ゲストユーザーの編集・削除はできません！"
      end
    end
  end
end
