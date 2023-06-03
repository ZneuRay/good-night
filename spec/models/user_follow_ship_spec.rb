# == Schema Information
#
# Table name: user_follow_ships
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  follow_id  :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_user_follow_ships_on_follow_id  (follow_id)
#  index_user_follow_ships_on_user_id    (user_id)
#
require 'rails_helper'

RSpec.describe UserFollowShip, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
