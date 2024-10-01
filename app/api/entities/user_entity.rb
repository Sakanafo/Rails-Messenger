class Entities::UserEntity < Grape::Entity
  expose :id
  expose :name
  expose :email
end
