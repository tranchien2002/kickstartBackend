class Campaign < ApplicationRecord
  belongs_to :owner, class_name: User.name, foreign_key: :user_id
  has_many :requests
  has_many :user_campaigns, foreign_key: :campaign_id, dependent: :destroy
  has_many :contributors, through: :user_campaigns, source: :user
end
