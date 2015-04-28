class AddUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email_address, null: false
      t.timestamps
    end

    create_table :user_tokens do |t|
      t.belongs_to :user
      t.string :uid, null: false
      t.string :provider, null: false
      t.string :token, null: false
      t.string :secret
      t.string :refresh
      t.datetime :expires_at
      t.timestamps
    end
  end
end
