module Api
  module V1
    class UserSleepDiaryController < ApiController
      before_action :check_user
      def index
        response_success(Entities::UserSleepDiariesEntity.new(@user.user_sleep_diaries))
      end

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
