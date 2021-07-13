class Team < ApplicationRecord
  has_many :users, dependent: :nullify
  has_many :procedures, dependent: :nullify
  validates :name, presence: true
end
