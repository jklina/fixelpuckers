class User < ActiveRecord::Base
  include Clearance::User
  extend FriendlyId

  rolify
  acts_as_voter

  friendly_id :username, use: :slugged

  has_many :submissions
  has_many :comments
  has_attached_file :avatar, styles: { original: "100x100#", thumb: '32x32#' }

  validates :username, length: { maximum: 20 },
                       presence: true,
                       uniqueness: true
  validates :slug, presence: true
  validates :email, uniqueness: true
  validates_attachment :avatar, content_type:
    { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
    size: { in: 0..2.megabytes }

  def find_or_build_comment_from(author)
    comments.where(author_id: author.id).first_or_initialize
  end

  def to_s
    username
  end
end
