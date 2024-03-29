# == Schema Information
#
# Table name: user_following_user_ships
#
#  id                :bigint           not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  following_user_id :bigint
#  user_id           :bigint
#
# Indexes
#
#  index_on_user_id_and_following_user_id                (user_id,following_user_id) UNIQUE
#  index_user_following_user_ships_on_following_user_id  (following_user_id)
#  index_user_following_user_ships_on_user_id            (user_id)
#
require 'rails_helper'

RSpec.describe UserFollowingUserShip, type: :model do
  subject { create(:user_following_user_ship) }
  it 'is valid to create a following ship' do
    expect(subject).to be_valid
  end
end
