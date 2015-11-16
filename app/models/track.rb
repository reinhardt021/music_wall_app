class Track < ActiveRecord::Base
  validates :title, presence: true
  validates :author, presence: true
  validate :url_valid

  private

  def url_valid
    unless url.strip.empty?
      errors.add(:url, "must be valid youtube link") unless match_regex?
    end
  end 

  def match_regex?
    # url.match(/^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/)
    # url.match(/^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})/)
    url.match(/^https:\/\/www\.youtube\.com\/watch\?..\w+$/)
  end
end