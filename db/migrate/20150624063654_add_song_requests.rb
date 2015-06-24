class AddSongRequests < ActiveRecord::Migration
  def change
    add_column :rsvps, :song_requests, :text
  end
end
