module Api::V1::Params
  class UserFollowParams < ParamsValidatorBase
    attr_accessor :follow_user_id

    validates :follow_user_id, numericality: { only_integer: true }

    def init_params(user_follow_params)
      @follow_user_id = user_follow_params[:follow_user_id]
    end
  end
end
