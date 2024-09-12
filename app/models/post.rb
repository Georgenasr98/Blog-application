class Post < ApplicationRecord
  # Ensure required fields are present
  validates :title, :body, :tags, presence: true
  validates :tags, length: { minimum: 1, message: "must have at least one tag" }

  # Associations
  belongs_to :author, class_name: "User"
  has_many :comments, dependent: :destroy
end
