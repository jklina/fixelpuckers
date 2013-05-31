class User < ActiveRecord::Base
  extend FriendlyId

  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  friendly_id :username, use: :slugged

  has_many :submissions

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  validates :username, length: { maximum: 20 },
                       presence: true,
                       uniqueness: true
  validates :slug, presence: true

  def recent_submissions(number_of_submissions)
    submissions.order("created_at DESC").limit(number_of_submissions)
  end
end
