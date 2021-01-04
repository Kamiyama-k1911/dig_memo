# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  unconfirmed_email      :string(255)
#  username               :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :articles, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :article_questions, dependent: :destroy

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[ -~]{8,32}\z/.freeze
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :username, presence: true
  validates :email, presence: true, format: { with: EMAIL_REGEX }
  validates :password, presence: true, format: { with: PASSWORD_REGEX, message: "は半角英数字・小文字を含む8〜32文字で入力してください" }, on: :create

  def self.guest
    User.find_or_create_by!(username: "guest", email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.confirmed_at = Time.zone.now
    end
  end
end
