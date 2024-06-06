require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let(:users) { create_list(:user, 5) }
  let(:user) { users.first }
  let!(:messages) { create_list(:message, 10) }

  describe "GET #index" do
    it "renders the index template" do
      get :index
      expect(response).to be_successful
    end

    it 'assigns all messages to @messages' do
      get :index
      expect(assigns(:messages)).to match_array(Message.where(room_id: nil).order(created_at: :desc).limit(5))
      expect(response).to render_template(:index)
    end

    it 'instance Message is assigned to @new_message' do
      get :index
      expect(assigns(:new_message)).to be_a_new(Message)
    end

    it 'paginates messages' do
      get :index
      expect(assigns(:pagy)).to be_a(Pagy)
      expect(assigns(:pagy).items).to eq(5)
      expect(assigns(:messages).size).to eq(5)
      expect(assigns(:pagy).pages).to eq(2)
    end
  end

  describe 'POST #create' do
    context "when user is logged in" do
      before { sign_in user }

      context 'with valid attributes' do
        it 'creates a new message' do
          expect {
            post :create, params: { message: attributes_for(:message) }
          }.to change(Message, :count).by(1)
        end

        it 'redirects to the messages page' do
          request.env["HTTP_REFERER"] = messages_path
          post :create, params: { message: attributes_for(:message) }
          expect(response).to redirect_to(messages_path)
        end

        it "associates the message with the current user" do
          post :create, params: { message: attributes_for(:message) }
          expect(Message.last.user).to eq(controller.current_user)
        end
      end

      context 'with invalid params' do
        it 're-renders the index template' do
          request.env["HTTP_REFERER"] = messages_path
          post :create, params: { message: { body: '' } }
          expect(response).to redirect_to(messages_path)
          expect(flash[:error]).to be_present
        end
      end
    end

    context 'when user is not logged in' do
      before { sign_out :user }

      it "does not create a new message" do
        expect {
          post :create, params: { message: attributes_for(:message) }
        }.not_to change(Message, :count)
      end

      it 'redirects to the login page' do
        post :create, params: { message: attributes_for(:message) }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:user_message) { create(:message, user: users[0]) }
    let!(:other_user_message) { create(:message, user: users[1]) }

    context "when user is logged in" do
      before { sign_in users[0] }

      it "deletes their own message" do
        expect {
          delete :destroy, params: { id: user_message.id }
        }.to change(Message, :count).by(-1)
        expect(flash[:notice]).to be_present
      end

      it "redirects after deleting their message" do
        request.env["HTTP_REFERER"] = messages_path
        delete :destroy, params: { id: user_message.id }
        expect(response).to redirect_to(messages_path)
      end

      it "does not delete a message belonging to another user" do
        expect {
          delete :destroy, params: { id: other_user_message.id }
        }.not_to change(Message, :count)
        expect(flash[:error]).to be_present
      end

      it "redirects to fallback location when trying to delete another user's message" do
        request.env["HTTP_REFERER"] = messages_path
        delete :destroy, params: { id: other_user_message.id }
        expect(response).to redirect_to(messages_path)
      end
    end

    context "when user is not logged in" do
      before { sign_out :user }

      it "does not delete any messages" do
        expect {
          delete :destroy, params: { id: user_message.id }
        }.not_to change(Message, :count)
      end

      it "redirects to the login page" do
        delete :destroy, params: { id: user_message.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
