class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string :provider
      t.string :uid
      t.string :merchant_id
      t.string :token
      t.boolean :expires
      t.datetime :expires_at
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
