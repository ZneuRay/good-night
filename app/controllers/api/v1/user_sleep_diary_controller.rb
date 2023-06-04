module Api
  module V1
    class UserSleepDiaryController < ApiController
      before_action :check_user
      def index
        response_success(Entities::UserSleepDiariesEntity.new(@user.user_sleep_diaries))
      end

      private

      def check_user
        @user = User.find_by(id: params[:user_id])
        response_error(ApiCode::RECORD_NOT_FOUND, 'user not found') and return if @user.nil?
      end
    end
  end
end
