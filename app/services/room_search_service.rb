class RoomSearchService
  def initialize(query)
    @query = query
  end

  def search
    Room.left_joins(:user, messages: :user)
        .where('rooms.name ILIKE :query OR
                users.name ILIKE :query OR
                messages.body ILIKE :query OR
                users_messages.name ILIKE :query', query: "%#{@query}%")
        .distinct
  end
end
