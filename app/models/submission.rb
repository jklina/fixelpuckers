class Submission < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user
  has_many :reviews, after_add: :update_average_rating, after_remove: :update_average_rating

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

  private

  def update_average_rating(review)
    self.average_rating = calculate_average_rating
    self.save!
  end

  def calculate_average_rating
    num_of_reviews = reviews.count
    reviews.inject(0) {|sum, review| sum + review.rating}.to_f / num_of_reviews
  end
end
