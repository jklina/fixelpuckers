class Comment < ActiveRecord::Base
  attr_accessible :body

  belongs_to :author, class_name: "User"
  belongs_to :user

  validates :body, :author_id, :user_id, presence: true
end
