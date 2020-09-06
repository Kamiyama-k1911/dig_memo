# == Schema Information
#
# Table name: articles
#
#  id          :bigint           not null, primary key
#  body1       :text
#  body2       :text
#  body3       :text
#  body4       :text
#  body5       :text
#  body6       :text
#  body7       :text
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint
#  user_id     :bigint           not null
#
# Indexes
#
#  index_articles_on_category_id  (category_id)
#  index_articles_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

# RSpec.describe Article, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end
