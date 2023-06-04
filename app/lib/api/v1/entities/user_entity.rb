module Api::V1::Entities
  class UserEntity
    attr_accessor :id, :name

    def initialize(user)
      @id = user.id
      @name = user.name
    end

    def to_json(*_args)
      {
        id: @id,
        name: @name
      }
    end
  end
end
