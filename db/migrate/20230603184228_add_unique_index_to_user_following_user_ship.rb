class AddUniqueIndexToUserFollowingUserShip < ActiveRecord::Migration[7.0]
  def up
    add_index :user_following_user_ships, %i[user_id following_user_id], name: :index_on_user_id_and_following_user_id,
                                                                         unique: true
  end

  def down
    remove_index :user_following_user_ships, %i[user_id following_user_id]
  end
end
