class ArticleQuestionsController < ApplicationController
  def create
    @article_questions = current_user.article_questions.build(article_question_param)

    if @article_questions.save
      respond_to do |format|
        format.js { flash.now[:notice] = "問い : #{@article_questions.question}を追加しました！" }
      end
    else
      respond_to do |format|
        format.js { flash.now[:alert] = "既に作られている問い・または空文字の入力は受け付けられません" }
      end
    end
  end

  def destroy
    @article_question = current_user.article_questions.find(params[:id])
    if @article_question.destroy!
      respond_to do |format|
        format.js { flash.now[:alert] = "問い : #{@article_question.question}を削除しました！" }
      end
    end
  end

  private

    def article_question_param
      params.permit(:question, :user_id)
    end
end
