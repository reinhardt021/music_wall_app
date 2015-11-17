class AddUserColumnToTracks < ActiveRecord::Migration
  def change
    add_reference :tracks, :user, index: true
    add_foreign_key :tracks, :users
  end
end
