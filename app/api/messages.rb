class Messages < BaseApi
  resource :messages do
    desc 'Return messages from general chat'
    # GET /api/v1/messages
    get do
      message = Message.where(room_id: nil).order(created_at: :desc)
      present paginate(message), with: Entities::MessageEntity
    end

    desc 'Return a specific messages'
    # GET /api/v1/messages/:id
    route_param :id do
      get do
        present Message.find(params[:id]), with: Entities::MessageEntity
      end
    end

    desc 'Create a new message'
    # POST /api/v1/messages/
    params do
      requires :user_id, type: Integer, desc: 'User ID'
      requires :body, type: String, desc: 'Body message'
      optional :room_id, type: Integer, desc: 'Room ID'
    end
    post do
      # authenticate_user!
      present Message.create(params), with: Entities::MessageEntity
    end
  end
end
