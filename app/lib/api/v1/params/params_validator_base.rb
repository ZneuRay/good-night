# frozen_string_literal: true

module Api::V1::Params
  class ParamsValidatorBase
    include ActiveModel::Validations

    # @param [ActionController::Parameters] params
    def initialize(params = ActionController::Parameters.new)
      init_params(params)
    end

    # @param [ActionController::Parameters] params
    def init_params(params)
      raise NotImplementedError, "`#{__method__}` is not implemented"
    end

    # @return [string]
    def error_messages
      errors&.full_messages&.to_sentence
    end
  end
end
