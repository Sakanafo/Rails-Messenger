require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe Rooms do
  let(:room) { create(:room) }
  let!(:user) { create(:user) }
  let(:headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }
  let(:auth_headers) { Devise::JWT::TestHelpers.auth_headers(headers, user) }

  describe 'GET /api/v1/rooms' do
    let!(:rooms) { create_list(:room, 3) }

    context 'when authenticated' do
      it 'returns a list of rooms' do
        get('/api/v1/rooms', headers: auth_headers)
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).size).to eq(3)
      end

      it 'paginates results' do
        get('/api/v1/rooms', params: { per_page: 2, page: 1 }, headers: auth_headers)
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).size).to eq(2)
      end

      it 'searches rooms' do
        create(:room, name: 'Searchable')
        get('/api/v1/rooms', params: { query: 'Search' }, headers: auth_headers)
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).size).to eq(1)
        expect(JSON.parse(response.body)[0]['name']).to eq('Searchable')
      end
    end

    context 'when not authenticated' do
      it 'returns unauthorized' do
        get '/api/v1/rooms'
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /api/v1/rooms/:id' do
    let!(:room) { create(:room) }

    context 'when authenticated' do
      it 'returns a specific room' do
        get "/api/v1/rooms/#{room.id}", headers: auth_headers
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['id']).to eq(room.id)
      end

      it 'returns 404 for non-existent room' do
        get '/api/v1/rooms/999999', headers: auth_headers
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'GET /api/v1/rooms/:id/messages' do
    let!(:room) { create(:room) }
    let!(:messages) { create_list(:message, 3, room: room) }

    context 'when authenticated' do
      it 'returns messages for a specific room' do
        get "/api/v1/rooms/#{room.id}/messages", headers: auth_headers
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).size).to eq(3)
      end
    end
  end

  describe 'POST /api/v1/rooms' do
    context 'when authenticated' do
      it 'creates a new room' do
        post '/api/v1/rooms', params: { name: 'New Room' }.to_json, headers: auth_headers
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['name']).to eq('New Room')
      end

      it 'returns error for invalid room' do
        post '/api/v1/rooms', params: { name: '' }.to_json, headers: auth_headers
        expect(response).to have_http_status(:unprocessable_content)
        expect(JSON.parse(response.body)).to have_key('error')
      end
    end
  end
end
