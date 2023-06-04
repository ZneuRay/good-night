module Api::V1::Entities
  class EntityBase
    def initialize(object)
      init_entity(object)
    end

    def init_entity(_object)
      raise NotImplementedError, "`#{__method__}` is not implemented"
    end

    def to_json(*_args)
      raise NotImplementedError, "`#{__method__}` is not implemented"
    end
  end
end
