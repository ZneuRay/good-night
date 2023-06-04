# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  disabled   :boolean          default(FALSE)
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  validates_presence_of :name

  after_create :create_user_sleep_meta

  # Following users relationships
  has_many :user_following_user_ships
  has_many :following_users, through: :user_following_user_ships

  # Followers relationships
  has_many :user_follower_ships, class_name: 'UserFollowingUserShip', foreign_key: :following_user_id
  has_many :followers, through: :user_follower_ships, source: :user

  # Sleep data
  has_one :user_sleep_meta

  # @param [User] user
  # @return [Boolean]
  def follow(user)
    return false if id == user.id

    following_users << user
    true
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:user_id, e.record.errors.full_messages.to_sentence)
    false
  end

  # @param [User] user
  def unfollow(user)
    return false if id == user.id

    following_users.delete(user)
    true
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:user_id, e.record.errors.full_messages.to_sentence)
    false
  end
end
