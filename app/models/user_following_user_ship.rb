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
class UserFollowingUserShip < ApplicationRecord
  validates :user, uniqueness: { scope: :following_user }
  validate :cannot_follow_yourself

  belongs_to :user
  belongs_to :following_user, class_name: 'User'

  private

  def cannot_follow_yourself
    errors.add(:user_id, 'cannot follow yourself') if user_id == following_user_id
  end
end
