# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  unconfirmed_email      :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :user do
    username { Faker::Name.name }
    sequence(:email) {|n| "#{n}_#{Faker::Internet.email}" }
    password { Faker::Internet.password(min_length: 8, max_length: 32, mix_case: true, special_characters: true) }
    confirmation_token { SecureRandom.urlsafe_base64 }

    trait :unconfirmation do
      confirmation_token { nil }
    end
  end

  factory :satoshi, class: "User" do
    username { "satoshi" }
    email { "satoshi@example.com" }
    password { "satoshi1290" }

    confirmation_token { Faker::Lorem.characters(16) }

    trait :unconfirmation do
      confirmation_token { nil }
    end
  end

  factory :takeshi, class: "User" do
    username { "takeshi" }
    email { "takeshi@example.com" }
    password { "takeshi1290" }
  end
end
