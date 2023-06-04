module Api::V1::Entities
  class UserSleepRecordEntity < EntityBase
    attr_accessor :start_time, :end_time, :total_sleep_minutes, :create_at

    # @param  [UserSleepDiary diary_record
    def init_entity(sleep_record)
      @start_time = sleep_record.start_time
      @end_time = sleep_record.end_time
      @total_sleep_minutes = sleep_record.total_sleep_minute
      @created_at = sleep_record.created_at
    end

    def to_json(*_args)
      {
        start_time: @start_time,
        end_time: @end_time,
        total_sleep_minutes: @total_sleep_minutes,
        created_at: @created_at
      }
    end
  end
end
