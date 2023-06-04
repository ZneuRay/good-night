# == Schema Information
#
# Table name: user_sleep_meta
#
#  id                       :bigint           not null, primary key
#  disabled                 :boolean          default(FALSE)
#  user_sleep_diaries_count :integer          default(0)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  user_id                  :bigint
#
# Indexes
#
#  index_user_sleep_meta_on_user_id  (user_id)
#
class UserSleepMeta < ApplicationRecord
  belongs_to :user
  has_many :user_sleep_diaries
end
