module Api::V1::Params
  class UserParams < ParamsValidatorBase
    attr_accessor :name

    validates :name, length: { maximum: 100 }

    def init_params(user_params)
      @name = user_params[:name]
    end
  end
end
