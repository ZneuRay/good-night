class ChangeUserFollowShipToUserFollowingShip < ActiveRecord::Migration[7.0]
  def up
    rename_table :user_follow_ships, :user_following_user_ships
    rename_column :user_following_user_ships, :follow_id, :following_user_id
  end

  def down
    rename_column :user_following_user_ships, :following_user_id, :follow_id
    rename_table :user_following_user_ships, :user_follow_ships
  end
end
