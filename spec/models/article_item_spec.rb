# == Schema Information
#
# Table name: article_items
#
#  id                  :bigint           not null, primary key
#  body                :text(65535)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  article_id          :bigint
#  article_question_id :bigint
#
# Indexes
#
#  index_article_items_on_article_id           (article_id)
#  index_article_items_on_article_question_id  (article_question_id)
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#  fk_rails_...  (article_question_id => article_questions.id)
#
require "rails_helper"

# RSpec.describe ArticleItem, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end
