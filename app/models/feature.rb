class Feature < ActiveRecord::Base
  belongs_to :author, class_name: "User", foreign_key: "user_id"
  belongs_to :submission
  has_attached_file :preview, styles: {thumbnail: "90x90>", full: "1088x363>"}

  validates :description, :user_id, presence: true
  validates_attachment :preview, content_type:
    { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
    size: { in: 0..8.megabytes }
  validates :preview, attachment_presence: true

  default_scope { order(created_at: :desc) }
end
