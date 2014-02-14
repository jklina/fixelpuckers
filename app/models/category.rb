class Category < ActiveRecord::Base
  extend FriendlyId

  validates :name, :slug, presence: true

  has_many :submissions

  friendly_id :name, use: :slugged
end
