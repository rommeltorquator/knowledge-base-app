class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :procedures, dependent: :nullify
  belongs_to :team

  validates :email, :first_name, :last_name, :type, presence: true
  validates :email, uniqueness: true

  def admin?
    type == 'Admin'
  end

  def member?
    type == 'Member'
  end
end
