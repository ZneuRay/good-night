require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'GET /index' do
    it 'returns all users' do
      get '/api/v1/users'
      expect(response).to have_http_status(:ok)

      body = response.body
      json_body = JSON.parse(body)
      expect(json_body['status']).to eq(0)
      expect(json_body['data'].size).to eq(User.count)
    end
  end
end
