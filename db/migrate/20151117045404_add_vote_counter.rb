class AddVoteCounter < ActiveRecord::Migration
  def change
    add_column :votes, :status, :integer 
  end
end
