module Api::V1::Entities
  class FollowingUsersSleepDiaryReportEntity < EntityBase
    attr_accessor :reports

    def init_entity(diary_records)
      @reports = {}
      diary_records.each do |diary_record|
        user = diary_record.user_sleep_meta.user
        if @reports[user.id].nil?
          @reports[user.id] = {
            user: UserEntity.new(user).to_json,
            sleep_length: 0,
            diary_records: []
          }
        end

        @reports[user.id][:sleep_length] += (diary_record.total_sleep_minute || 0)
        @reports[user.id][:diary_records] << UserSleepDiaryEntity.new(diary_record)
      end
    end

    def to_json(*_args)
      @reports.map { |_, report| report }
              .sort_by { |report| report[:sleep_length] }
              .reverse
    end
  end
end
