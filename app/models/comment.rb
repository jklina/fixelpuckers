class Comment < ActiveRecord::Base
  attr_accessible :body

  belongs_to :author, class_name: "User"
  belongs_to :commentable, :polymorphic => true

  validates :body, :author_id, :commentable_id, :commentable_type,
            presence: true
end
