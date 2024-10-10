class Rooms < BaseApi
  before { authenticate! }

  resource :rooms do
    desc 'Return list of rooms'
    # GET /api/v1/rooms
    # GET /api/v1/rooms?query=_
    # GET /api/v1/rooms?per_page=_&page=_
    # GET /api/v1/rooms?page=_
    params do
      optional :page, type: Integer, default: 1
      optional :per_page, type: Integer, default: 8
    end
    get do
      rooms = Room.all
      rooms = RoomSearchService.new(params[:query]).search if params[:query].present?
      present paginate(rooms), with: Entities::RoomEntity
    end

    desc 'Return a specific room'
    # GET /api/v1/rooms/:id
    route_param :id do
      get do
        room = Room.find_by(id: params[:id])
        if room
          present room, with: Entities::RoomEntity
        else
          error!('Room not found', 404)
        end
        # present Room.find(params[:id]), with: Entities::RoomEntity
      end
    end

    desc 'Get messages for a specific room'
    # GET /api/v1/rooms/:id/messages
    route_param :id do
      route_param :messages do
        get do
          room = Room.find(params[:id])
          paginate(room.messages)
        end
      end
    end

    desc 'Create a new room'
    # POST /api/v1/rooms
    params do
      requires :name, type: String, desc: 'Room name'
    end
    post do
      new_room = Room.create({ name: params[:name], user_id: current_user.id })
      if new_room.save
        present new_room, with: Entities::RoomEntity
      else
        error!({ error: 'Failed to create room', details: new_room.errors.full_messages }, 422)
      end
    end
  end
end
