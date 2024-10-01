class Entities::RoomEntity < Grape::Entity
  expose :id
  expose :name
  expose :created_at do |e|
    e.created_at.strftime("%Y-%m-%d %H:%M:%S")
  end
  expose :author, if: ->(room) { room.user.present? } do |room|
    room.user&.name
  end
end
