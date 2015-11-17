class Vote < ActiveRecord::Base
  belongs_to :track
  belongs_to :user

  validate :user_cannot_vote_twice

  def user_cannot_vote_twice
    vote = self.track.votes.find_by(user_id: self.user_id)
    if vote
      errors[:base] = "User already voted for this track"
    end
  end
end