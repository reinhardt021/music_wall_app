class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :track

  # need to add restriction to only create one review per user
  
end