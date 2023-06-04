module Api
  module V1
    class UserSleepDiaryController < ApiController
      def index
        user = User.find(params[:user_id])

        response_success(Entities::UserSleepDiariesEntity.new(user.user_sleep_meta.user_sleep_diaries))
      end
    end
  end
end
