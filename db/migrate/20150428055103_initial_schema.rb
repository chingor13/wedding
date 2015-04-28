class InitialSchema < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.string :name, null: false
      t.string :email_address, null: false
      t.boolean :attending, default: false
      t.text :notes
      t.integer :total, default: 0
      t.string :code, null: false
      t.integer :max_attending, null: false, default: 1
      t.datetime :responded_at
      t.datetime :created_at
    end

    create_table :honeymoon_payments do |t|
      t.text :notes
      t.string :description
      t.string :charge_identifier
      t.integer :amount
      t.integer :created_by_id
      t.timestamps
    end

    create_table :addresses do |t|
      t.integer :owner_id, null: false
      t.string :owner_type, null: false
      t.string :line1, null: false
      t.string :line2
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip, null: false
      t.timestamps
    end
  end
end
