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

      def create
        user_params = Params::UserParams.new(params)
        response_error(ApiCode::PARAMS_NOT_VALID, user_params.error_messages) and return if user_params.invalid?

        user = User.new
        user.name = user_params.name
        response_error(ApiCode::RECORD_NOT_VALID, user.errors.full_messages.to_sentence) and return if user.invalid?

        user.save
        response_success(Entities::UserEntity.new(user))
      end

      def follow
        user = User.find_by(id: params[:id])
        response_error(ApiCode::RECORD_NOT_FOUND, 'user not found') and return if user.nil?

        user_follow_params = Params::UserFollowParams.new(params)
        response_error(ApiCode::PARAMS_NOT_VALID, user_params.error_messages) and return if user_follow_params.invalid?

        follow_user = User.find_by(id: user_follow_params.follow_user_id)
        response_error(ApiCode::RECORD_NOT_FOUND, 'user not found') and return if follow_user.nil?

        unless user.follow(follow_user)
          response_error(ApiCode::CANNOT_FOLLOW_USER,
                         user.errors.full_messages.to_sentence) and return
        end

        response_success(Entities::UserEntity.new(user))
      end
    end
  end
end
