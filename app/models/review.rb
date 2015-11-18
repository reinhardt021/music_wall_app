class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :track

  # need to add restriction to only create one review per user
  validate :just_one_review

  def just_one_review
    review = self.track.reviews.find_by(user_id: self.user_id)
    if review
      errors[:base] = "User already reviewed this track"
    end
  end
end