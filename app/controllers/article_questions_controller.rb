class ArticleQuestionsController < ApplicationController
  def create
    @article_questions = current_user.article_questions.build(article_question_param)

    return unless @article_questions.save

    respond_to do |format|
      format.js { flash.now[:notice] = "問い : #{@article_questions.question}を追加しました！" }
    end
  end

  def destroy
    @article_question = current_user.article_questions.find(params[:article_question][:id])

    @article_question.destroy!

    respond_to do |format|
      format.js { flash.now[:alert] = "問い : #{@article_question.question}を削除しました！" }
    end
    # flash[:alert] = "問いを削除しました！"
    # redirect_back(fallback_location: articles_path)
  end

  private

    def article_question_param
      params.permit(:question, :user_id)
    end
end
