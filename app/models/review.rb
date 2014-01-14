class Review < ActiveRecord::Base
  belongs_to :submission
  belongs_to :user

  validates :comment, presence: true

  acts_as_votable

  def selector
    "review-#{id}"
  end
end
