module Api
  module V1
    class ApiResponse
      # An implementation of the API response.
      # The `data` attribute is present only in successful responses,
      # while the `message` attribute is present only in failure responses.
      attr_accessor :status, :message
      attr_reader :data

      def initialize
        @status = Api::V1::ApiCode::SUCCESS
        @data = {}
        @message = ''
      end

      # @param [Object] response_data
      # @return nil
      def data=(response_data)
        @data = response_data
        success!
      end

      # @return [Integer]
      def success!
        @status = Api::V1::ApiCode::SUCCESS
      end

      # @return [Boolean]
      def success?
        return true if @status == Api::V1::ApiCode::SUCCESS

        false
      end

      # @param [Api::V1::ApiCode] status_code
      # @param [String] error_message
      # @return nil
      def set_error(status_code, error_message)
        @status = status_code
        @message = error_message
      end

      # @return [Object]
      def to_response
        response = {}
        response[:status] = @status
        if success?
          response[:data] = @data
        else
          response[:message] = @message
        end
        response
      end
    end
  end
end
