module Api::V1::Entities
  class UserSleepDiaryEntity < EntityBase
    attr_accessor :bed_time, :wake_time, :total_sleep_minutes, :diary_date, :status

    # @param  [UserSleepDiary diary_record
    def init_entity(diary_record)
      @bed_time = diary_record.bed_time
      @wake_time = diary_record.wake_time
      @total_sleep_minutes = diary_record.total_sleep_minute
      @diary_date = diary_record.record_date
      @status = diary_record.status
    end

    def to_json(*_args)
      {
        bed_time: @bed_time,
        wake_time: @wake_time,
        total_sleep_minutes: @total_sleep_minutes,
        diary_date: @diary_date,
        status: @status
      }
    end
  end
end
