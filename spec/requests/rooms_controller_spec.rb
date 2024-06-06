require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "GET #index" do
    let!(:room1) { create(:room, name: 'AlphaRoom') }
    let!(:room2) { create(:room, name: 'BetaRoom') }
    let!(:other_rooms) { create_list(:room, 10) }

    context 'without any params' do
      it 'renders a successful response and assigns the first page of rooms' do
        get :index
        expect(response).to be_successful
        expect(assigns(:rooms)).to include(room1, room2)
        expect(assigns(:rooms).size).to eq(8)
      end
    end

    context 'with name param' do
      it 'filters rooms by name' do
        get :index, params: { name: 'Alpha' }
        expect(assigns(:rooms)).to contain_exactly(room1)
        expect(assigns(:rooms).size).to eq(1)
      end
    end

    context 'pagination' do
      it 'paginates the rooms' do
        get :index, params: { page: 2 }
        expect(assigns(:rooms).size).to eq(4)
        expect(assigns(:rooms)).not_to include(room1, room2)
      end
    end
  end

  describe "GET #show" do
    let(:room) { create(:room) }
    let!(:messages) { create_list(:message, 10, room:) }

    before do
      get :show, params: { id: room.id }
    end

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it 'assigns the requested room to @room' do
      expect(assigns(:room)).to eq(room)
    end

    context 'when room does not exist' do
      it 'raises an error' do
        expect { get :show, params: { id: 'nonexistent' } }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'GET #new' do
    before do
      get :new
    end

    it 'assigns a new Room to @room' do
      expect(assigns(:room)).to be_a_new(Room)
    end

    it 'renders the new template' do
      expect(response).to render_template('new')
    end
  end

  describe "POST #create" do
    context 'with valid attributes' do
      it 'creates a new room' do
        expect {
          post :create, params: { room: attributes_for(:room) }
        }.to change(Room, :count).by(1)
      end

      it 'redirects to the newly created room' do
        post :create, params: { room: attributes_for(:room) }
        expect(response).to redirect_to(Room.last)
        expect(flash[:notice]).to eq('Room was successfully created.')
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new room' do
        expect {
          post :create, params: { room: attributes_for(:room, name: nil) } # предположим, что имя обязательно
        }.to_not change(Room, :count)
      end

      it 're-renders the new method' do
        post :create, params: { room: attributes_for(:room, name: nil) }
        expect(response).to render_template(:new)
      end
    end
  end
end
