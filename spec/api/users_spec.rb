require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe Users do
  describe 'POST api/v1/users/sign_in' do
    let!(:user) { create(:user) }
    let(:url) { '/api/v1/users/sign_in' }
    let(:params) do
      {
        email: user.email,
        password: user.password
      }
    end

    context 'with valid credentials' do
      it 'returns a success message and user details' do
        # puts "URL: #{url}"
        # puts "Params: #{params.to_json}"
        post(url, params: params)
        # puts "User ID: #{user.id}"
        # puts "Auth params: #{params.inspect}"
        # puts "Response status: #{response.status}"
        # puts "Response headers: #{response.headers.inspect}"

        expect(response).to have_http_status(201)
        json_response = JSON.parse(response.body)
        # puts "Json_response: #{json_response.inspect}"
        expect(json_response['message']).to eq('Login successful')
        expect(json_response['user']['email']).to eq(user.email)
        expect(json_response['user']['name']).to eq(user.name)
        expect(response.headers['Authorization']).to be_present
      end
    end

    context 'with invalid credentials' do
      it 'returns an error message' do
        post '/api/v1/users/sign_in', params: { email: user.email, password: 'wrongpassword' }

        expect(response).to have_http_status(:unauthorized)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('Invalid email or password')
      end
    end
  end
end
