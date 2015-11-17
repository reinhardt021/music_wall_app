class AddVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.belongs_to :track
      t.belongs_to :user
      t.timestamps
    end
  end
end
