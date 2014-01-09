class Review < ActiveRecord::Base
  belongs_to :submission
  belongs_to :user

  validates :comment, presence: true
end
