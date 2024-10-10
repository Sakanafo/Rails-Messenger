class Messages < BaseApi
  before { authenticate! }

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
        message = Message.find_by(id: params[:id])
        if message
          present message, with: Entities::MessageEntity
        else
          error!('Message not found', 404)
        end
        # present Message.find(params[:id]), with: Entities::MessageEntity
      end
    end

    desc 'Create a new message'
    # POST /api/v1/messages/
    params do
      requires :body, type: String, desc: 'Body message'
      optional :room_id, type: Integer, desc: 'Room ID'
    end
    post do
      message = current_user.messages.create({ body: params[:body], room_id: params[:room_id] })
      if message.save
        present message, with: Entities::MessageEntity
      else
        error!({ error: 'Failed to create message', details: message.errors.full_messages }, 422)
      end
    end
  end
end
