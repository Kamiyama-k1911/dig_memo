# == Schema Information
#
# Table name: article_items
#
#  id         :bigint           not null, primary key
#  body       :text
#  question   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :bigint
#
# Indexes
#
#  index_article_items_on_article_id  (article_id)
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#
require 'rails_helper'

RSpec.describe ArticleItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
