class User < ActiveRecord::Base
  include Clearance::User
  extend FriendlyId

  rolify
  acts_as_voter

  friendly_id :username, use: :slugged

  has_many :submissions
  has_many :comments

  validates :username, length: { maximum: 20 },
                       presence: true,
                       uniqueness: true
  validates :slug, presence: true
  validates :email, uniqueness: true

  def recent_submissions(number_of_submissions)
    submissions.limit(number_of_submissions)
  end

  def find_or_build_comment_from(author)
    comments.where(author_id: author.id).first_or_initialize
  end
end
