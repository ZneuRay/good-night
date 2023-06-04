module Api
  module V1
    class UsersController < ApiController
      def index
        response_success(Entities::UsersEntity.new(User.all))
      end
    end
  end
end
