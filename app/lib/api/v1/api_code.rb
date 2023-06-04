module Api
  module V1
    module ApiCode
      # success
      SUCCESS = 0

      # failure
      RECORD_NOT_FOUND = 1
      PARAMS_NOT_VALID = 2
      RECORD_NOT_VALID = 3

      # User failure
      CANNOT_FOLLOW_USER = 100
      CANNOT_UNFOLLOW_USER = 101
    end
  end
end
