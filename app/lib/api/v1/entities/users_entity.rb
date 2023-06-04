module Api::V1::Entities
  class UsersEntity
    attr_accessor :users

    def initialize(user_records)
      @users = []
      user_records.each do |user_record|
        @users << UserEntity.new(user_record)
      end
    end

    def to_json(*_args)
      @users.map(&:to_json)
    end
  end
end
