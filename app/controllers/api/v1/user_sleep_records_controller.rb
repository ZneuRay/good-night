module Api
  module V1
    class UserSleepRecordsController < ApiController

      resource_description do
        short 'User Sleep Records'
        description 'API endpoints for managing user sleep records and sleep tracking data'
        formats ['json']
        error code: 400, desc: 'Bad Request - Invalid parameters'
        error code: 404, desc: 'Not Found - User not found'
        error code: 422, desc: 'Unprocessable Entity - Validation errors'
        error code: 500, desc: 'Internal Server Error'
      end

      before_action :check_user

      api :GET, '/api/v1/users/:user_id/user_sleep_records', 'Get user sleep records'
      description 'Returns all sleep records for a specific user, ordered by creation time'
      param :user_id, Integer, desc: 'User ID', required: true
      returns code: 200, desc: 'Success' do
        property :status, String, desc: 'Response status'
        property :data, Array, desc: 'Array of sleep record objects' do
          property :id, Integer, desc: 'Sleep record ID'
          property :start_time, String, desc: 'Sleep start time (ISO 8601 format)'
          property :end_time, String, desc: 'Sleep end time (ISO 8601 format)'
          property :total_sleep_minute, Integer, desc: 'Total sleep duration in minutes'
          property :user_sleep_diary_id, Integer, desc: 'Associated sleep diary ID'
        end
      end
      returns code: 404, desc: 'User not found'
      returns code: 500, desc: 'Internal server error'
      def index
        user_sleep_diary_ids = @user.user_sleep_diaries.pluck(:id)
        user_sleep_records = UserSleepRecord.where(user_sleep_diary_id: user_sleep_diary_ids).order(:created_at)

        response_success(Entities::UserSleepRecordsEntity.new(user_sleep_records))
      end

      api :POST, '/api/v1/users/:user_id/user_sleep_records', 'Create a new sleep record'
      description <<-DESC
        Creates a new sleep record for a user. This will also create or update the associated sleep diary entry.
        The diary entry tracks the earliest bed time and latest wake time across all sleep records for a given date.
      DESC
      param :user_id, Integer, desc: 'User ID', required: true
      param :diary_date, String, desc: 'Date of the sleep record (YYYY-MM-DD format)', required: true
      param :start_time, Integer, desc: 'Sleep start time as Unix timestamp', required: true
      param :end_time, Integer, desc: 'Sleep end time as Unix timestamp', required: true
      param :total_minutes, Integer, desc: 'Total sleep duration in minutes', required: true
      returns code: 200, desc: 'Sleep record created successfully' do
        property :status, String, desc: 'Response status'
        property :data, Hash, desc: 'Created/updated sleep diary object' do
          property :id, Integer, desc: 'Sleep diary ID'
          property :record_date, String, desc: 'Date of the sleep diary entry'
          property :bed_time, String, desc: 'Earliest bed time for the day (ISO 8601 format)'
          property :wake_time, String, desc: 'Latest wake time for the day (ISO 8601 format)'
          property :user_sleep_records, Array, desc: 'All sleep records for this diary entry'
        end
      end
      returns code: 400, desc: 'Invalid parameters'
      returns code: 404, desc: 'User not found'
      returns code: 422, desc: 'Validation errors'
      returns code: 500, desc: 'Internal server error'
      example <<-EXAMPLE
        Request:
        POST /api/v1/users/1/user_sleep_records
        {
          "diary_date": "2025-07-16",
          "start_time": 1721077200,
          "end_time": 1721106000,
          "total_minutes": 480
        }

        Response:
        {
          "status": "success",
          "data": {
            "id": 123,
            "record_date": "2025-07-16",
            "bed_time": "2025-07-16T22:00:00Z",
            "wake_time": "2025-07-16T06:00:00Z",
            "user_sleep_records": [
              {
                "id": 456,
                "start_time": "2025-07-16T22:00:00Z",
                "end_time": "2025-07-16T06:00:00Z",
                "total_sleep_minute": 480
              }
            ]
          }
        }
      EXAMPLE
      def create
        user_sleep_record_create_params = Params::UserSleepRecordCreateParams.new(params)
        if user_sleep_record_create_params.invalid?
          response_error(ApiCode::PARAMS_NOT_VALID,
                         user_sleep_record_create_params.error_messages) and return
        end

        sleep_meta = @user.user_sleep_meta
        diary = sleep_meta.user_sleep_diaries.where(record_date: user_sleep_record_create_params.diary_date).first_or_initialize

        # build user_sleep_record
        user_sleep_record = diary.user_sleep_records.new
        user_sleep_record.start_time = Time.at(user_sleep_record_create_params.start_time.to_i)
        user_sleep_record.end_time = Time.at(user_sleep_record_create_params.end_time.to_i)
        user_sleep_record.total_sleep_minute = user_sleep_record_create_params.total_minutes

        if diary.new_record?
          diary.bed_time = user_sleep_record.start_time
          diary.wake_time = user_sleep_record.end_time
        else
          diary.bed_time = user_sleep_record.start_time if diary.bed_time > user_sleep_record.start_time
          diary.wake_time = user_sleep_record.end_time if diary.wake_time < user_sleep_record.end_time
        end
        diary.save

        response_success(Entities::UserSleepDiaryEntity.new(diary))
      end

      private

      def check_user
        @user = User.find_by(id: params[:user_id])
        response_error(ApiCode::RECORD_NOT_FOUND, 'user not found') and return if @user.nil?
      end
    end
  end
end
