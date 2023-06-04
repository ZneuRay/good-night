module Api::V1::Entities
  class UserEntity < EntityBase
    attr_accessor :id, :name

    def init_entity(user)
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
