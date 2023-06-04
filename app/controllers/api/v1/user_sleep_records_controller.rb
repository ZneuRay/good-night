module Api
  module V1
    class UserSleepRecordsController < ApiController
      before_action :check_user

      def index
        user_sleep_diary_ids = @user.user_sleep_diaries.pluck(:id)
        user_sleep_records = UserSleepRecord.where(user_sleep_diary_id: user_sleep_diary_ids).order(:created_at)

        response_success(Entities::UserSleepRecordsEntity.new(user_sleep_records))
      end

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
