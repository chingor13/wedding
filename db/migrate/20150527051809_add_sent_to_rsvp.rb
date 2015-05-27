class AddSentToRsvp < ActiveRecord::Migration
  def change
    add_column :rsvps, :sent, :boolean, default: false
  end
end
