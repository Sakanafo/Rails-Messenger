require_relative 'helpers/pagination_helpers'
require_relative 'helpers/users_helpers'

class BaseApi < Grape::API
  version 'v1', using: :path
  format :json
  prefix :api

  helpers Pagy::Backend
  helpers PaginationHelpers
  helpers UsersHelpers

  rescue_from :all do |e|
    error!({ error: e.message }, 500)
  end

  mount Rooms
  mount Messages
  mount Users
end
