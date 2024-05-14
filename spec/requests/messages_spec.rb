require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  describe "GET #index" do
    it 'shows messages' do
      get :index
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new message and redirects to messages_path" do
        valid_params = { message: { body: "Test message" } }
        expect {
          post :create, params: valid_params
        }.to change(Message, :count).by(1)

        expect(response).to redirect_to(messages_path)
      end
    end

    context "with invalid parameters" do
      it "renders the root_path" do
        invalid_params = { message: { body: nil } }

        expect {
          post :create, params: invalid_params
        }.not_to change(Message, :count)

        expect(response).to redirect_to(messages_path)
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the message and redirects to messages_path" do
      message = FactoryBot.create(:message)
      expect {
        delete :destroy, params: { id: message.id }
      }.to change(Message, :count).by(-1)

      expect(response).to redirect_to(messages_path)
    end
  end
end
