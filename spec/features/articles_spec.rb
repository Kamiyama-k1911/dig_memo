require "rails_helper"

RSpec.describe "Articles", js: true, type: :feature do
  describe "自分の投稿の操作" do
    before do
      create(:satoshi)
      create(:learn)
      create(:impression)
      create(:answer)
      create(:other)

      visit new_user_session_path

      fill_in "メールアドレス", with: "satoshi@example.com"
      fill_in "パスワード", with: "satoshi1290"
      click_button "ログイン"
    end

    it "新規投稿→投稿編集→投稿削除" do
      visit new_article_path

      select "その他", from: "article[category_id]"
      fill_in "タイトル", with: "こんにちは"

      click_button "投稿する"

      expect(page).to have_content "こんにちは"
      expect(page).to have_current_path articles_path, ignore_query: true

      visit edit_article_path(Article.find_by(title: "こんにちは"))

      fill_in "タイトル", with: "こんばんは"

      click_button "編集する"

      expect(page).to have_content "こんばんは"
      expect(page).to have_content "投稿を編集しました！"

      accept_confirm do
        find(".destroy").click
      end

      expect(page).to have_content "投稿を削除しました！"
    end

    it "投稿詳細が取得できる" do
      visit new_article_path

      select "その他", from: "article[category_id]"
      fill_in "タイトル", with: "こんにちは"

      click_button "投稿する"

      expect(page).to have_content "こんにちは"
      expect(page).to have_current_path articles_path, ignore_query: true

      visit article_path(Article.find_by(title: "こんにちは"))

      expect(page).to have_content "こんにちは"
      expect(page).to have_current_path article_path(Article.find_by(title: "こんにちは")), ignore_query: true
    end

    it "タイトルと複数の内容を投稿できる" do
      # 新規投稿画面
      visit new_article_path

      select "その他", from: "article[category_id]"
      fill_in "タイトル", with: "こんにちは"
      click_button "問い+"

      select "why", from: "items[item1][]"
      fill_in "items[item1][]", with: "なぜこんにちはと言うのか？"

      select "where", from: "items[item2][]"
      fill_in "items[item2][]", with: "ドイツ語でこんにちははなんと言うのか？"

      click_button "投稿する"

      # 投稿一覧画面
      expect(page).to have_content "こんにちは"
      expect(page).to have_current_path articles_path, ignore_query: true

      visit article_path(Article.find_by(title: "こんにちは"))

      # 投稿詳細画面
      expect(page).to have_content "こんにちは"
      expect(page).to have_content "why"
      expect(page).to have_content "なぜこんにちはと言うのか？"
      expect(page).to have_content "where"
      expect(page).to have_content "ドイツ語でこんにちははなんと言うのか？"
      expect(page).to have_current_path article_path(Article.find_by(title: "こんにちは")), ignore_query: true
    end

    it "タイトルと複数の内容の投稿を編集し、問いを1つ増やせる" do
      # 新規投稿画面
      visit new_article_path

      select "その他", from: "article[category_id]"
      fill_in "タイトル", with: "こんにちは"
      click_button "問い+"

      select "why", from: "items[item1][]"
      fill_in "items[item1][]", with: "なぜこんにちはと言うのか？"

      select "where", from: "items[item2][]"
      fill_in "items[item2][]", with: "ドイツ語でこんにちははなんと言うのか？"

      click_button "投稿する"

      # 投稿一覧画面
      expect(page).to have_content "こんにちは"
      expect(page).to have_current_path articles_path, ignore_query: true

      visit edit_article_path(Article.find_by(title: "こんにちは"))

      # 投稿編集画面
      click_button "問い+"

      select "who", from: "items[item3][]"
      fill_in "items[item3][]", with: "こんにちはは誰が作った言葉なのか？"

      click_button "編集する"

      expect(page).to have_current_path articles_path, ignore_query: true

      visit edit_article_path(Article.find_by(title: "こんにちは"))

      # 投稿詳細画面
      expect(page).to have_content "こんにちは"
      expect(page).to have_content "why"
      expect(page).to have_content "なぜこんにちはと言うのか？"
      expect(page).to have_content "where"
      expect(page).to have_content "ドイツ語でこんにちははなんと言うのか？"
      expect(page).to have_content "who"
      expect(page).to have_content "こんにちはは誰が作った言葉なのか？"
    end

    it "タイトルと複数の内容の投稿を編集し、問いを1つ減らす" do
      # 新規投稿画面
      visit new_article_path

      select "その他", from: "article[category_id]"
      fill_in "タイトル", with: "こんにちは"
      click_button "問い+"

      select "why", from: "items[item1][]"
      fill_in "items[item1][]", with: "なぜこんにちはと言うのか？"

      select "where", from: "items[item2][]"
      fill_in "items[item2][]", with: "ドイツ語でこんにちははなんと言うのか？"

      click_button "投稿する"

      # 投稿一覧画面
      expect(page).to have_content "こんにちは"
      expect(page).to have_current_path articles_path, ignore_query: true

      visit edit_article_path(Article.find_by(title: "こんにちは"))

      # 投稿編集画面
      accept_confirm do
        click_link "問い-"
      end

      click_button "編集する"

      expect(page).to have_current_path articles_path, ignore_query: true

      visit article_path(Article.find_by(title: "こんにちは"))

      # 投稿詳細画面
      expect(page).not_to have_content "ドイツ語でこんにちははなんと言うのか？"
      expect(page).not_to have_content "where"
    end
  end

  describe "他のユーザーの投稿を操作しようとする" do
    before do
      create(:satoshi)
      create(:takeshi_article)
      create(:learn)
      create(:impression)
      create(:answer)
      create(:other)

      visit new_user_session_path

      fill_in "メールアドレス", with: "satoshi@example.com"
      fill_in "パスワード", with: "satoshi1290"
      click_button "ログイン"
    end

    it "他のユーザーの投稿を編集できない" do
      visit edit_article_path(1)

      expect(page).to have_content "他のユーザーの投稿は編集できません！"
      expect(page).to have_current_path articles_path
    end

    it "他のユーザーの投稿詳細を見ることができない" do
      visit article_path(1)

      expect(page).to have_content "他のユーザーの投稿を見ることはできません！"
      expect(page).to have_current_path articles_path
    end
  end

  describe "カテゴリー別に分けられるか" do
    before do
      create(:satoshi, id: 1)
      create(:learn)
      create(:impression)
      create(:answer)
      create(:other)
      create(:learn_article, user_id: 1, category_id: 1)
      create(:impression_article, user_id: 1, category_id: 2)
      create(:answer_article, user_id: 1, category_id: 3)
      create(:other_article, user_id: 1, category_id: 4)

      visit new_user_session_path

      fill_in "メールアドレス", with: "satoshi@example.com"
      fill_in "パスワード", with: "satoshi1290"
      click_button "ログイン"
    end

    it "カテゴリー分けできる" do
      click_link "学び"
      expect(page).to have_content "学び！"

      click_link "感想"
      expect(page).to have_content "感想！"

      click_link "質問への回答"
      expect(page).to have_content "質問への回答！"

      click_link "その他"
      expect(page).to have_content "その他！"
    end
  end
end
