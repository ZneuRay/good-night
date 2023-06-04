# == Schema Information
#
# Table name: user_sleep_diaries
#
#  id                  :bigint           not null, primary key
#  bed_time            :datetime
#  record_date         :date
#  status              :integer          default(0)
#  total_sleep_minute  :integer          default(0)
#  wake_time           :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  bed_time_record_id  :integer
#  user_sleep_meta_id  :bigint
#  wake_time_record_id :integer
#
# Indexes
#
#  index_user_sleep_diaries_on_bed_time_record_id   (bed_time_record_id)
#  index_user_sleep_diaries_on_record_date          (record_date)
#  index_user_sleep_diaries_on_user_sleep_meta_id   (user_sleep_meta_id)
#  index_user_sleep_diaries_on_wake_time_record_id  (wake_time_record_id)
#
class UserSleepDiary < ApplicationRecord
  before_commit :calculate_total_sleep_minutes

  belongs_to :user_sleep_meta, counter_cache: true
  has_many :user_sleep_records

  private

  def calculate_total_sleep_minutes
    return if bed_time.nil? || wake_time.nil?

    self.total_sleep_minute = (wake_time - bed_time) / 60 + 1
  end
end
