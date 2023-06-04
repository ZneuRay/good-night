module Api::V1::Entities
  class UserSleepRecordsEntity < EntityBase
    attr_accessor :records

    # @param  [UserSleepRecord[]] sleep_records
    def init_entity(sleep_records)
      @records = []
      sleep_records.each do |sleep_record|
        @records << UserSleepRecordEntity.new(sleep_record)
      end
    end

    def to_json(*_args)
      @records.map(&:to_json)
    end
  end
end
