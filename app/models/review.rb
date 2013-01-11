class Review < ActiveRecord::Base
  attr_accessible :comment, :rating

  belongs_to :submission
  belongs_to :user

  validates :comment, presence: true
end
