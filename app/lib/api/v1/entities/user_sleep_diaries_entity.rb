module Api::V1::Entities
  class UserSleepDiariesEntity < EntityBase
    attr_accessor :diaries

    # @param  [UserSleepDiary[]] diary_records
    def init_entity(diary_records)
      @diaries = []
      diary_records.each do |diary_record|
        @diaries << UserSleepDiaryEntity.new(diary_record)
      end
    end

    def to_json(*_args)
      @diaries.map(&:to_json)
    end
  end
end
