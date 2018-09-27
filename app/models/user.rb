class User < ApplicationRecord
  has_many :campaigns 
  validates_presence_of :email, :password_digest
  validates :email, uniqueness: true
  has_secure_password
  has_many :user_campaigns, foreign_key: :user_id, dependent: :destroy
  has_many :contributions, through: :user_campaigns, source: :campaign
end
