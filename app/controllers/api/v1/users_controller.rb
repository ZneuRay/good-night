module Api
  module V1
    class UsersController < ApiController
      def index
        response_success(Entities::UsersEntity.new(User.all))
      end

      def show
        user = User.find_by(id: params[:id])
        if user
          response_success(Entities::UserEntity.new(user))
        else
          response_error(ApiCode::RECORD_NOT_FOUND, 'user not found')
        end
      end
    end
  end
end
