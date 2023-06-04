module Api::V1::Params
  class UserSleepRecordCreateParams < ParamsValidatorBase
    attr_accessor :diary_date, :start_time, :end_time, :state, :record_time

    validate :validate_date
    validates :start_time, numericality: { integer: true }
    validates :end_time, numericality: { integer: true }

    def init_params(user_sleep_record_create_params)
      @diary_date = user_sleep_record_create_params[:diary_date]
      @record_time = user_sleep_record_create_params[:record_time]

      # start_time & end_time should be unix timestamp
      @start_time = user_sleep_record_create_params[:start_time]
      @end_time = user_sleep_record_create_params[:end_time]
    end

    def total_minutes
      (@end_time - @start_time) / 60 + 1
    end

    def validate_date
      Date.iso8601(@diary_date)
      if @start_time > @end_time
        errors.add(:start_time, 'end time must be greater than start time')
        return false
      end

      true
    rescue Date::Error => e
      errors.add(:diary_date, e.message)
      false
    end
  end
end
