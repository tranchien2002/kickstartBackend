class CreateUserCampaigns < ActiveRecord::Migration[5.1]
  def change
    create_table :user_campaigns do |t|
      t.references :campaign, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      
      t.timestamps
    end
  end
end
