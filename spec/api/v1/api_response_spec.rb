require 'rails_helper'

RSpec.describe Api::V1::ApiResponse do
  context 'in successful response' do
    it 'returns status 0' do
      response = described_class.new
      expect(response.status).to eq(Api::V1::ApiCode::SUCCESS)
    end
  end
end
