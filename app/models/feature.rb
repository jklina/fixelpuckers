class Feature < ActiveRecord::Base
  belongs_to :author, class_name: "User", foreign_key: "user_id"
  belongs_to :submission

  validates :description, :user_id, presence: true
end
