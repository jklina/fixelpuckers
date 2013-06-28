require 'reviews'

class Submission < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user
  has_many :reviews

  attr_accessible :description, :title

  friendly_id :title, use: :slugged

  validates :title, :description, :user_id, :slug, presence: true
  validates :title, length: { maximum: 120 }
  validates :views, numericality: { only_integer: true }, allow_blank: true
  validates :downloads, numericality: { only_integer: true }, allow_blank: true
  validates :average_rating, numericality:true , allow_blank: true

  # TODO: Validate that there can only be 1 review per user per submission

  def find_or_build_review_from(user)
    reviews.where(user_id: user.id).first_or_initialize
  end

  def update_average_rating
    self.average_rating = Pf::Reviews.calc_average_rating(reviews)
    self.save!
  end
end
