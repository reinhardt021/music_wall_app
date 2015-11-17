class Track < ActiveRecord::Base
  belongs_to :user
  has_many :votes

  validates :title, presence: true
  validates :author, presence: true
  validate :url_valid

  private

  def url_valid
    if url
      unless url.strip.empty?
        errors.add(:url, "must be valid youtube link") unless match_regex?
      end
    end
  end 

  def match_regex?
    url.match(/^https:\/\/www\.youtube\.com\/watch\?/)
  end
end