class CreateCampaigns < ActiveRecord::Migration[5.1]
  def change
    create_table :campaigns do |t|
      t.string  :public_key
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
