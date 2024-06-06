class Room < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :nullify

  validates :name, uniqueness: true, presence: true, length: { in: 3..12 }
end
