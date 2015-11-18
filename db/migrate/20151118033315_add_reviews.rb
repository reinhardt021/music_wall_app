class AddReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :comment
      t.belongs_to :track
      t.belongs_to :user
      t.timestamps
    end 
  end
end
