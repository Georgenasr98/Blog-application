class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  # Ensure all required fields are present
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
  validates :password, presence: true
  validates :image, presence: true

  # This will create a virtual `password` attribute and handle encryption
  has_secure_password

  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
end
