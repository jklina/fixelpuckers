class Submission < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user
  has_many :reviews

  attr_accessible :description, :title

  friendly_id :title, use: :slugged

  validates :title, :description, :user_id, :slug, presence: true
  validates :title, length: { maximum: 120 }

  # TODO: Validate that there can only be 1 review per user per submission

  def find_or_build_review_from(user)
    reviews.where(user_id: user.id).first_or_initialize
  end

  def average_rating
  end

  def downloads
  end
  
  def views
  end

  def has_ratings?
  end

  def featured_at
  end

  def featured?
  end
end
