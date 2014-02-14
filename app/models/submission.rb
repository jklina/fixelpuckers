require 'reviews'

class Submission < ActiveRecord::Base
  extend FriendlyId

  belongs_to :author, class_name: "User", foreign_key: "user_id"
  belongs_to :category
  has_many :reviews

  friendly_id :title, use: :slugged

  default_scope { order(created_at: :desc) }

  validates :title, :description, :user_id, :slug, presence: true
  validates :title, length: { maximum: 120 }
  validates :views, numericality: { only_integer: true }, allow_blank: true
  validates :downloads, numericality: { only_integer: true }, allow_blank: true
  validates :average_rating, numericality:true , allow_blank: true

  # TODO: Validate that there can only be 1 review per user per submission

  def self.filtered_trash_for(author)
    where("trashed = ? or user_id = ?", false, author)
  end
  
  def find_or_build_review_from(user)
    reviews.where(user_id: user.id).first_or_initialize
  end

  def update_average_rating
    self.average_rating = Pf::Reviews.calc_average_rating(reviews)
    self.save!
  end

  def increment_views!
    self.views += 1
    self.save!
  end

  def toggle_trash!
    if trashed?
      self.trashed = false
    else
      self.trashed = true
    end
    self.save!
  end
end
