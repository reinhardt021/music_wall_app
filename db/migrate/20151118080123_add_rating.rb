class AddRating < ActiveRecord::Migration
  def change
    add_column :reviews, :rating, :integer 
  end
end
