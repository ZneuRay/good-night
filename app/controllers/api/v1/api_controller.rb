module Api
  module V1
    class ApiController < ApplicationController
      # @param [Api::V1::Entities::EntityBase] response_entity
      def response_success(response_entity = nil)
        render json: {} if response_entity.nil?

        api_response.data = response_entity.to_json
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
