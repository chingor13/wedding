class InitialSchema < ActiveRecord::Migration
  def change
    create_table :wedding_rsvps do |t|
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

    create_table :wedding_honeymoon_payments do |t|
      t.text :notes
      t.string :description
      t.string :charge_identifier
      t.integer :amount
      t.integer :created_by_id
      t.timestamps
    end
  end
end
