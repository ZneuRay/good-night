module Api
  module V1
    class UserSleepDiaryController < ApiController
      def index
        user = User.find_by(id: params[:user_id])
        response_error(ApiCode::RECORD_NOT_FOUND, 'user not found') and return if user.nil?

        response_success(Entities::UserSleepDiariesEntity.new(user.user_sleep_meta.user_sleep_diaries))
      end
    end
  end
end
