class Comment < ApplicationRecord
  # Ensure body is present
  validates :body, presence: true

  # Associations
  belongs_to :post
  belongs_to :author, class_name: 'User'
end
