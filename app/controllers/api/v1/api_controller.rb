module Api
  module V1
    class ApiController < ApplicationController
      # @param [Object] response_data
      def response_success(response_data)
        api_response.data = response_data

        render json: api_response.to_response
      end

      def response_error(status_code, error_message)
        api_response.set_error(status_code, error_message)

        render json: api_response.to_response
      end

      private

      # @return [Api::V1::ApiResponse]
      def api_response
        @api_response ||= ApiResponse.new
      end
    end
  end
end
