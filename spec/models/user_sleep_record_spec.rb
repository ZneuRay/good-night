# == Schema Information
#
# Table name: user_sleep_records
#
#  id                  :bigint           not null, primary key
#  end_time            :datetime
#  record_time         :datetime
#  start_time          :datetime
#  state               :integer          default(0)
#  total_sleep_minute  :integer          default(0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_sleep_diary_id :bigint
#
# Indexes
#
#  index_user_sleep_records_on_user_sleep_diary_id  (user_sleep_diary_id)
#
require 'rails_helper'

RSpec.describe UserSleepRecord, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
