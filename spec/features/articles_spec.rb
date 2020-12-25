require "rails_helper"

RSpec.describe "Articles", js: true, type: :feature do
  describe "正常系" do
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

    context "投稿が存在しない時" do
      it "メモが見つからないと表示される" do
        click_button "検索"

        expect(page).to have_content "検索ワードに一致するメモは見つかりませんでした"
      end
    end

    context "投稿が存在する場合" do
      let!(:satoshi_article) { create(:satoshi_article_1) }

      it "タイトル編集ができる" do
        visit edit_article_path(satoshi_article.id)

        fill_in "タイトル", with: "こんばんは"
        click_button "編集する"

        expect(page).to have_content "こんばんは"
        expect(page).to have_content "投稿を編集しました！"
      end

      it "投稿削除ができる" do
        visit articles_path

        accept_confirm do
          find(".destroy").click
        end

        expect(page).to have_content "投稿を削除しました！"
      end

      it "お気に入りが機能する" do
        visit articles_path

        find(".favorite-link").click

        visit favorites_index_path

        expect(page).to have_content satoshi_article.title
      end
    end

    context "お気に入りの投稿が存在する場合" do
      let!(:satoshi_article) { create(:satoshi_article_1, favorite: true) }

      it "お気に入りを解除する" do
        visit articles_path

        find(".erase-favorite-link").click

        expect(page).to have_selector ".favorite-link"

        visit favorites_index_path

        expect(page).not_to have_content satoshi_article.title
      end
    end

    context "投稿が複数存在する時" do
      before do
        create(:satoshi_article_1)
        create(:satoshi_article_2)
      end

      it "検索が機能する" do
        fill_in "検索フォーム", with: "ポケモン"
        click_button "検索"

        expect(page).to have_content "ポケモン"
        expect(page).not_to have_content "デジモン"
      end
    end

    context "問いが既に存在している場合" do
      before do
        create(:question_why)
        create(:question_where)
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

        select "なぜ？", from: "items[item1][]"
        fill_in "items[item1][]", with: "なぜこんにちはと言うのか？"

        click_on "自問自答を増やす"

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

        select "なぜ？", from: "items[item1][]"
        fill_in "items[item1][]", with: "なぜこんにちはと言うのか？"

        click_on "自問自答を増やす"

        select "どこで？", from: "items[item2][]"
        fill_in "items[item2][]", with: "ドイツ語でこんにちははなんと言うのか？"

        click_button "投稿する"

        # 投稿一覧画面
        expect(page).to have_content "こんにちは"
        expect(page).to have_current_path articles_path, ignore_query: true

        visit edit_article_path(Article.find_by(title: "こんにちは"))

        # 投稿編集画面
        click_on "問いを増やす"

        sleep 0.5

        fill_in "create-question-form", with: "誰？"
        click_on "作成する"

        expect(page).to have_content("問い : 誰？を追加しました！")

        click_on "自問自答を増やす"

        sleep 0.5

        select "誰？", from: "items[item3][]"
        fill_in "items[item3][]", with: "こんにちはは誰が作った言葉なのか？"

        click_button "編集する"

        expect(page).to have_current_path articles_path, ignore_query: true

        visit article_path(Article.find_by(title: "こんにちは"))

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

        select "なぜ？", from: "items[item1][]"
        fill_in "items[item1][]", with: "なぜこんにちはと言うのか？"

        click_on "自問自答を増やす"

        select "どこで？", from: "items[item2][]"
        fill_in "items[item2][]", with: "ドイツ語でこんにちははなんと言うのか？"

        click_button "投稿する"

        # 投稿一覧画面
        expect(page).to have_content "こんにちは"
        expect(page).to have_current_path articles_path, ignore_query: true

        visit edit_article_path(Article.find_by(title: "こんにちは"))

        # 投稿編集画面
        accept_confirm do
          click_link "自問自答を減らす"
        end

        click_button "編集する"

        expect(page).to have_current_path articles_path, ignore_query: true

        visit article_path(Article.find_by(title: "こんにちは"))

        # 投稿詳細画面
        expect(page).not_to have_content "ドイツ語でこんにちははなんと言うのか？"
        expect(page).not_to have_content "どこで？"
      end

      context "メモの内容に含まれるもじが検索された時" do
        before do
          visit new_article_path

          fill_in "タイトル", with: "こんにちは"

          select "なぜ？", from: "items[item1][]"
          fill_in "items[item1][]", with: "なぜこんにちはと言うのか？"

          click_on "自問自答を増やす"

          select "どこで？", from: "items[item2][]"
          fill_in "items[item2][]", with: "ドイツ語でこんにちははなんと言うのか？"

          click_button "投稿する"
        end
        fit "検索内容が含まれるタイトルのメモが表示される" do
          fill_in "検索フォーム", with: "ドイツ語"
          click_button "検索"

          expect(page).not_to have_content "どこで？"
        end
      end
    end
  end

  describe "異常系" do
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

    context "他のユーザーの投稿を操作しようとした場合" do
      let!(:takeshi_article) { create(:takeshi_article) }

      fit "他のユーザーの投稿を編集できない" do
        visit edit_article_path(takeshi_article)
        expect(page).to have_content "他のユーザーの投稿の閲覧・編集はできません！"
        expect(page).to have_current_path articles_path
      end

      it "他のユーザーの投稿詳細を見ることができない" do
        visit article_path(1)

        expect(page).to have_content "他のユーザーの投稿の閲覧・編集はできません！"
        expect(page).to have_current_path articles_path
      end
    end

    context "タイトルを入力せず投稿しようとした時" do
      let!(:satoshi_article) { create(:satoshi_article_1) }

      it "投稿編集画面でフラッシュメッセージが表示される" do
        visit edit_article_path(satoshi_article)
        fill_in "タイトル", with: nil

        click_on "編集する"

        expect(page).to have_content "タイトルを入力してください！"
      end

      it "新規投稿画面でフラッシュメッセージが表示される" do
        visit new_article_path
        click_on "投稿する"

        expect(page).to have_content "タイトルを入力してください！"
      end
    end

    context "問いを選ばずに投稿した場合" do
      it "メモ詳細画面の問いの欄に「問いが選ばれていません」と表示される" do
        visit new_article_path

        fill_in "タイトル", with: "こんにちは"

        fill_in "items[item1][]", with: "なぜこんにちはと言うのか？"
        click_on "投稿する"

        expect(page).to have_current_path articles_path, ignore_query: true

        article = Article.find_by(title: "こんにちは")
        visit article_path(article.id)

        expect(page).to have_content "問いが選ばれていません"
      end
    end
  end
end
