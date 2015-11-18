class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :track

  validates :rating, 
    presence: true, 
    numericality: { only_integer: true,
                    greater_than_or_equal_to: 1,
                    less_than_or_equal_to: 5 }
  validate :just_one_review

  def just_one_review
    review = self.track.reviews.find_by(user_id: self.user_id)
    if review
      errors[:base] = "User already reviewed this track"
    end
  end
end