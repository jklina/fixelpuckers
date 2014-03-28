class NewsArticle < ActiveRecord::Base
  extend FriendlyId

  validates :title, :story, presence: true

  friendly_id :title, use: :slugged
end
