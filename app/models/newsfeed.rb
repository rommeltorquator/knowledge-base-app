class Newsfeed < ApplicationRecord
  belongs_to :user
  validates :body, presence: true
end
