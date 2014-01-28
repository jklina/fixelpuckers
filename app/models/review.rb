class Review < ActiveRecord::Base
  belongs_to :submission
  belongs_to :author, class_name: "User", foreign_key: "user_id"

  validates :comment, presence: true

  acts_as_votable

  def selector
    "review-#{id}"
  end
end
