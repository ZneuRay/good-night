module Api
  module V1
    class UsersController < ApiController

      resource_description do
        short 'User Management'
        description 'API endpoints for managing users, following/unfollowing relationships'
        formats ['json']
        error code: 400, desc: 'Bad Request - Invalid parameters'
        error code: 404, desc: 'Not Found - Resource not found'
        error code: 422, desc: 'Unprocessable Entity - Validation errors'
        error code: 500, desc: 'Internal Server Error'
      end

      api :GET, '/api/v1/users', 'List all users'
      description 'Returns a list of all users in the system'
      returns code: 200, desc: 'Success' do
        property :status, String, desc: 'Response status'
        property :data, Array, desc: 'Array of user objects' do
          property :id, Integer, desc: 'User ID'
          property :name, String, desc: 'User name'
        end
      end
      returns code: 500, desc: 'Internal server error'
      def index
        response_success(Entities::UsersEntity.new(User.all))
      end

      api :GET, '/api/v1/users/:id', 'Get user details'
      description 'Returns details of a specific user'
      param :id, Integer, desc: 'User ID', required: true
      returns code: 200, desc: 'Success' do
        property :status, String, desc: 'Response status'
        property :data, Hash, desc: 'User object' do
          property :id, Integer, desc: 'User ID'
          property :name, String, desc: 'User name'
        end
      end
      returns code: 404, desc: 'User not found'
      returns code: 500, desc: 'Internal server error'
      def show
        user = User.find_by(id: params[:id])
        if user
          response_success(Entities::UserEntity.new(user))
        else
          response_error(ApiCode::RECORD_NOT_FOUND, 'user not found')
        end
      end

      api :POST, '/api/v1/users', 'Create a new user'
      description 'Creates a new user in the system'
      param :name, String, desc: 'User name', required: true
      returns code: 200, desc: 'User created successfully' do
        property :status, String, desc: 'Response status'
        property :data, Hash, desc: 'Created user object' do
          property :id, Integer, desc: 'User ID'
          property :name, String, desc: 'User name'
        end
      end
      returns code: 400, desc: 'Invalid parameters'
      returns code: 422, desc: 'Validation errors'
      returns code: 500, desc: 'Internal server error'
      def create
        user_params = Params::UserParams.new(params)
        response_error(ApiCode::PARAMS_NOT_VALID, user_params.error_messages) and return if user_params.invalid?

        user = User.new
        user.name = user_params.name
        response_error(ApiCode::RECORD_NOT_VALID, user.errors.full_messages.to_sentence) and return if user.invalid?

        user.save
        response_success(Entities::UserEntity.new(user))
      end

      api :POST, '/api/v1/users/:id/follow', 'Follow a user'
      description 'Make the current user follow another user'
      param :id, Integer, desc: 'User ID who will follow', required: true
      param :follow_user_id, Integer, desc: 'ID of user to follow', required: true
      returns code: 200, desc: 'Successfully followed user' do
        property :status, String, desc: 'Response status'
        property :data, Hash, desc: 'Updated user object'
      end
      returns code: 400, desc: 'Invalid parameters'
      returns code: 404, desc: 'User not found'
      returns code: 422, desc: 'Cannot follow user (validation error)'
      returns code: 500, desc: 'Internal server error'
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

      api :POST, '/api/v1/users/:id/unfollow', 'Unfollow a user'
      description 'Make the current user unfollow another user'
      param :id, Integer, desc: 'User ID who will unfollow', required: true
      param :follow_user_id, Integer, desc: 'ID of user to unfollow', required: true
      returns code: 200, desc: 'Successfully unfollowed user' do
        property :status, String, desc: 'Response status'
        property :data, Hash, desc: 'Updated user object'
      end
      returns code: 400, desc: 'Invalid parameters'
      returns code: 404, desc: 'User not found'
      returns code: 422, desc: 'Cannot unfollow user (validation error)'
      returns code: 500, desc: 'Internal server error'
      def unfollow
        user = User.find_by(id: params[:id])
        response_error(ApiCode::RECORD_NOT_FOUND, 'user not found') and return if user.nil?

        user_unfollow_params = Params::UserFollowParams.new(params)
        if user_unfollow_params.invalid?
          response_error(ApiCode::PARAMS_NOT_VALID,
                         user_params.error_messages) and return
        end

        unfollow_user = user.following_users.find_by(id: user_unfollow_params.follow_user_id)
        response_error(ApiCode::RECORD_NOT_FOUND, 'user not found') and return if unfollow_user.nil?

        unless user.unfollow(unfollow_user)
          response_error(ApiCode::CANNOT_UNFOLLOW_USER,
                         user.errors.full_messages.to_sentence) and return
        end

        response_success(Entities::UserEntity.new(user))
      end

      api :GET, '/api/v1/users/:id/following_users', 'Get users that a user is following'
      description 'Returns a list of users that the specified user is following'
      param :id, Integer, desc: 'User ID', required: true
      returns code: 200, desc: 'Success' do
        property :status, String, desc: 'Response status'
        property :data, Array, desc: 'Array of following user objects' do
          property :id, Integer, desc: 'User ID'
          property :name, String, desc: 'User name'
        end
      end
      returns code: 404, desc: 'User not found'
      returns code: 500, desc: 'Internal server error'
      def following_users
        user = User.find_by(id: params[:id])
        response_error(ApiCode::RECORD_NOT_FOUND, 'user not found') and return if user.nil?

        response_success(Entities::UsersEntity.new(user.following_users))
      end
    end
  end
end
