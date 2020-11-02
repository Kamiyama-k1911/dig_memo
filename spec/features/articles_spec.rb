require "rails_helper"

RSpec.describe "Articles", js: true, type: :feature do
  describe "自分の投稿の操作" do
    before do
      create(:satoshi, id: 1)
      user = User.last
      token = user.confirmation_token

      visit user_confirmation_path(confirmation_token: token)

      accept_confirm do
        click_on "ログアウト"
      end

      sleep 0.5

      visit new_user_session_path

      fill_in "メールアドレス", with: "satoshi@example.com"
      fill_in "パスワード", with: "satoshi1290"
      click_button "ログイン"
    end

    it "新規投稿ができる" do
      visit new_article_path

      fill_in "タイトル", with: "こんにちは"

      click_button "投稿する"

      expect(page).to have_content "こんにちは"
      expect(page).to have_current_path articles_path, ignore_query: true
    end

    context "投稿が存在する場合" do
      before do
        visit new_article_path

        fill_in "タイトル", with: "こんにちは"

        click_button "投稿する"
      end

      it "タイトル編集ができる" do
        visit edit_article_path(Article.find_by(title: "こんにちは"))

        fill_in "タイトル", with: "こんばんは"

        click_button "編集する"

        expect(page).to have_content "こんばんは"
        expect(page).to have_content "投稿を編集しました！"
      end

      it "投稿削除ができる" do
        accept_confirm do
          find(".destroy").click
        end

        expect(page).to have_content "投稿を削除しました！"
      end

      it "お気に入りが機能する" do
        find(".favorite-link").click

        visit favorites_index_path

        expect(page).to have_content "こんにちは"
      end

      context "投稿が複数存在する時" do
        before do
          create(:satoshi_article_1, user_id: 1)
          create(:satoshi_article_2, user_id: 1)
        end

        it "検索が機能する" do
          fill_in "検索フォーム", with: "ポケモン"
          click_button "検索"

          expect(page).to have_content "ポケモン"
          expect(page).not_to have_content "デジモン"
        end
      end
    end

    it "投稿詳細が取得できる" do
      visit new_article_path

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

      fill_in "タイトル", with: "こんにちは"
      click_button "問い+"

      select "なぜ？", from: "items[item1][]"
      fill_in "items[item1][]", with: "なぜこんにちはと言うのか？"

      select "どこで？", from: "items[item2][]"
      fill_in "items[item2][]", with: "ドイツ語でこんにちははなんと言うのか？"

      click_button "投稿する"

      # 投稿一覧画面
      expect(page).to have_content "こんにちは"
      expect(page).to have_current_path articles_path, ignore_query: true

      visit article_path(Article.find_by(title: "こんにちは"))

      # 投稿詳細画面
      expect(page).to have_content "こんにちは"
      expect(page).to have_content "なぜ？"
      expect(page).to have_content "なぜこんにちはと言うのか？"
      expect(page).to have_content "どこで？"
      expect(page).to have_content "ドイツ語でこんにちははなんと言うのか？"
      expect(page).to have_current_path article_path(Article.find_by(title: "こんにちは")), ignore_query: true
    end

    it "タイトルと複数の内容の投稿を編集し、問いを1つ増やせる" do
      # 新規投稿画面
      visit new_article_path

      fill_in "タイトル", with: "こんにちは"
      click_button "問い+"

      select "なぜ？", from: "items[item1][]"
      fill_in "items[item1][]", with: "なぜこんにちはと言うのか？"

      select "どこで？", from: "items[item2][]"
      fill_in "items[item2][]", with: "ドイツ語でこんにちははなんと言うのか？"

      click_button "投稿する"

      # 投稿一覧画面
      expect(page).to have_content "こんにちは"
      expect(page).to have_current_path articles_path, ignore_query: true

      visit edit_article_path(Article.find_by(title: "こんにちは"))

      # 投稿編集画面
      click_button "問い+"

      select "誰？", from: "items[item3][]"
      fill_in "items[item3][]", with: "こんにちはは誰が作った言葉なのか？"

      click_button "編集する"

      expect(page).to have_current_path articles_path, ignore_query: true

      visit edit_article_path(Article.find_by(title: "こんにちは"))

      # 投稿詳細画面
      expect(page).to have_content "こんにちは"
      expect(page).to have_content "なぜ？"
      expect(page).to have_content "なぜこんにちはと言うのか？"
      expect(page).to have_content "どこで？"
      expect(page).to have_content "ドイツ語でこんにちははなんと言うのか？"
      expect(page).to have_content "誰？"
      expect(page).to have_content "こんにちはは誰が作った言葉なのか？"
    end

    it "タイトルと複数の内容の投稿を編集し、問いを1つ減らす" do
      # 新規投稿画面
      visit new_article_path

      fill_in "タイトル", with: "こんにちは"
      click_button "問い+"

      select "なぜ？", from: "items[item1][]"
      fill_in "items[item1][]", with: "なぜこんにちはと言うのか？"

      select "どこで？", from: "items[item2][]"
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
      expect(page).not_to have_content "どこで？"
    end

    context "他のユーザーの投稿を操作しようとした場合" do
      before do
        create(:takeshi_article)
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
  end

  # describe "カテゴリー別に分けられるか" do
  #   before do
  #     create(:satoshi, id: 1)

  #     user = User.last
  #     token = user.confirmation_token

  #     visit user_confirmation_path(confirmation_token: token)

  #     accept_confirm do
  #       click_on "ログアウト"
  #     end

  #     create(:learn)
  #     create(:impression)
  #     create(:answer)
  #     create(:other)
  #     create(:learn_article, user_id: 1, category_id: 1)
  #     create(:impression_article, user_id: 1, category_id: 2)
  #     create(:answer_article, user_id: 1, category_id: 3)
  #     create(:other_article, user_id: 1, category_id: 4)

  #     visit new_user_session_path

  #     fill_in "メールアドレス", with: "satoshi@example.com"
  #     fill_in "パスワード", with: "satoshi1290"
  #     click_button "ログイン"
  #   end

  #   it "カテゴリー分けできる" do
  #     click_link "学び"
  #     expect(page).to have_content "学び！"

  #     click_link "感想"
  #     expect(page).to have_content "感想！"

  #     click_link "質問への回答"
  #     expect(page).to have_content "質問への回答！"

  #     click_link "その他"
  #     expect(page).to have_content "その他！"
  #   end
  # end
end
