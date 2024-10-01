class Entities::MessageEntity < Grape::Entity
  expose :id
  expose :body
  expose :created_at do |e|
    e.created_at.strftime("%Y-%m-%d %H:%M:%S")
  end
  expose :user do |message|
    user = message.user
    {
      id: user&.id,
      name: user&.name,
      email: user&.email
    }
  end
  expose :room, if: ->(message) { message.room.present? } do |message|
    room = message.room
    {
      id: room&.id,
      name: room&.name
    }
  end
end
