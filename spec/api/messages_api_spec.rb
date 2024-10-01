require 'rails_helper'

RSpec.describe Messages, type: :request do
  # include Rack::Test::Methods
  describe 'GET /api//v1/rooms/:room_id/messages' do
    let(:room) { create(:room) }
    let(:message1) { create(:message, room: room, body: 'Message 1 Body') }
    let(:message2) { create(:message, room: room, body: 'Message 2 Body') }

    it 'returns a list of messages for a specific room' do
      get "/api/v1/rooms/#{room.id}/messages"

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(2)
      expect(JSON.parse(response.body)[0]['body']).to eq(message1.body)
      expect(JSON.parse(response.body)[1]['body']).to eq(message2.body)
    end
  end
end
