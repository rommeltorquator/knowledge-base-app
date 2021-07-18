class Procedure < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user
  belongs_to :team
  validates :title, :body, :user, presence: true

  has_rich_text :body
end
