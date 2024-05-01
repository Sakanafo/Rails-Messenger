class Message < ApplicationRecord
  validates :body, presence: true, length: {minimum: 1}

  def formatted_created_at
    self.created_at.strftime('%d/%m %H:%M:%S')
  end
end
