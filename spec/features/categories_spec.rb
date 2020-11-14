require "rails_helper"

RSpec.describe "Categories", js: true, type: :feature do
  let!(:user) { create(:user) }
  let!(:confirmation_token) { user.confirmation_token }

  before do
    # アカウントを有効化するURL
    visit user_confirmation_path(confirmation_token: confirmation_token)

    # ユーザー登録が完了した後、自動的にログインするように設定しているため、一旦ログアウト
    accept_confirm do
      click_on "ログアウト"
    end

    sleep 0.5

    visit new_user_session_path

    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"
  end

  context "カテゴリーがまだ存在していない状態" do
    it "カテゴリーが作成できる" do
      find("#category-create").click

      fill_in "create-category-form", with: "サンプル"
      click_button "作成する"

      expect(page).to have_content("カテゴリー : サンプルを新規作成しました！")
      expect(page).to have_content("サンプル")
    end
  end

  context "カテゴリーが既に存在している状態" do
    before do
      create(:sample, user_id: user.id)
    end

    it "カテゴリーを削除できる" do
      visit articles_path

      find("#category-destroy").click

      select "サンプル", from: "category[id]"
      accept_confirm do
        click_on "削除する"
      end

      expect(page).to have_content("カテゴリー : サンプルを削除しました！")

      visit articles_path

      expect(page).not_to have_content("サンプル")
    end

    it "作ったカテゴリーのメモが作成できる" do
      click_on "投稿"

      select "サンプル", from: "article[category_id]"
      fill_in "タイトル", with: "サンプルメモです"

      # select "なぜ？", from: "items[item1][]"
      # fill_in "内容1", with: "サンプルメモだから"

      click_on "投稿する"

      expect(page).to have_content("新規投稿しました！")

      article = Article.find_by(title: "サンプルメモです")
      visit categories_path(category_id: article.category_id)

      expect(page).to have_content("サンプルメモです")
    end

    context "カテゴリーが複数存在する場合" do
      before do
        create(:sample2, user_id: user.id)
        # 1つの記事と2つのカテゴリーを事前に用意する
        click_on "投稿"

        select "サンプル", from: "article[category_id]"
        fill_in "タイトル", with: "サンプルメモです"

        # select "なぜ？", from: "items[item1][]"
        # fill_in "内容1", with: "サンプルメモだから"
        click_button "投稿する"
      end

      it "別のカテゴリーに変えてメモ編集ができる" do
        sleep 0.5
        article = Article.find_by(title: "サンプルメモです")

        visit edit_article_path(article.id)

        select "サンプル2", from: "article[category_id]"

        click_button "編集する"

        expect(page).to have_content("投稿を編集しました！")

        edit_article = Article.find_by(title: "サンプルメモです")

        visit categories_path(category_id: edit_article.category_id)

        expect(page).to have_content("サンプルメモです")
      end
    end
  end
end
