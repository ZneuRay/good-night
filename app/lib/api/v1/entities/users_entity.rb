module Api::V1::Entities
  class UsersEntity < EntityBase
    attr_accessor :users

    def init_entity(user_records)
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
