class Submission < ActiveRecord::Base
  belongs_to :user
  has_many :reviews

  attr_accessible :description, :title

  validates :title, :description, :user_id, presence: true

  # TODO: Validate that there can only be 1 review per user per submission

  def review_from(user)
    reviews.where('user_id = ?', user.id).first
  end
end
