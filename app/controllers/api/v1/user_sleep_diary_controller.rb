module Api
  module V1
    class UserSleepDiaryController < ApiController

      resource_description do
        short 'User Sleep Diary'
        description 'API endpoints for managing user sleep diary entries'
        formats ['json']
        error code: 400, desc: 'Bad Request - Invalid parameters'
        error code: 404, desc: 'Not Found - User not found'
        error code: 500, desc: 'Internal Server Error'
      end

      before_action :check_user

      api :GET, '/api/v1/users/:user_id/user_sleep_diary', 'Get user sleep diary entries'
      description 'Returns all sleep diary entries for a specific user'
      param :user_id, Integer, desc: 'User ID', required: true
      returns code: 200, desc: 'Success' do
        property :status, String, desc: 'Response status'
        property :data, Array, desc: 'Array of sleep diary entries' do
          property :id, Integer, desc: 'Sleep diary entry ID'
          property :record_date, String, desc: 'Date of the sleep record'
        end
      end
      returns code: 404, desc: 'User not found'
      returns code: 500, desc: 'Internal server error'
      def index
        response_success(Entities::UserSleepDiariesEntity.new(@user.user_sleep_diaries))
      end

      api :GET, '/api/v1/users/:user_id/user_sleep_diary/following_users', 'Get sleep diary report for following users'
      description 'Returns sleep diary entries for users that the current user follows, including their own records from the previous week'
      param :user_id, Integer, desc: 'Current user ID', required: true
      returns code: 200, desc: 'Success' do
        property :status, String, desc: 'Response status'
        property :data, Array, desc: 'Array of sleep diary entries from following users' do
          property :user, Hash, desc: 'User information'
          property :sleep_entries, Array, desc: 'Sleep diary entries'
        end
      end
      returns code: 404, desc: 'User not found'
      returns code: 500, desc: 'Internal server error'
      def following_users
        user_sleep_meta_ids = @user.following_users.includes(:user_sleep_meta).map(&:user_sleep_meta).pluck(:id)
        # include self records
        user_sleep_meta_ids << @user.user_sleep_meta.id
        previous_week = 1.week.ago.at_beginning_of_week

        users_sleep_diaries = UserSleepDiary.includes(user_sleep_meta: :user).where(user_sleep_meta_id: user_sleep_meta_ids).where('record_date >= ?',
                                                                                                                                   previous_week).order(:record_date)
        response_success(Entities::FollowingUsersSleepDiaryReportEntity.new(users_sleep_diaries))
      end

      private

      def check_user
        @user = User.find_by(id: params[:user_id])
        response_error(ApiCode::RECORD_NOT_FOUND, 'user not found') and return if @user.nil?
      end
    end
  end
end
