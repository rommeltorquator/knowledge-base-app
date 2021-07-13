class Procedure < ApplicationRecord
  belongs_to :user
  belongs_to :team
  validates :title, :body, :user, presence: true

  has_rich_text :body
end
