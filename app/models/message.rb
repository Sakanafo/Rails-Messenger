# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room, optional: true
  validates :body, presence: true, length: { minimum: 1 }

  def formatted_created_at
    created_at.strftime('%d/%m %H:%M:%S ')
  end
end
