class Review < ActiveRecord::Base
  attr_accessible :body, :rating

  belongs_to :submission
  belongs_to :user

  validates :body, presence: true

  has_reputation :votes, aggregrated_by: :sum, source: :user
end
