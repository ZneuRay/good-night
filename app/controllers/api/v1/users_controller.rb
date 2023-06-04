module Api
  module V1
    class UsersController < ApiController
      def index
        api_response = Api::V1::ApiResponse.new
        api_response.data = User.all
        render json: api_response.to_json
      end
    end
  end
end
