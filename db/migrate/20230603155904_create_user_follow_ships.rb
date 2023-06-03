class CreateUserFollowShips < ActiveRecord::Migration[7.0]
  def change
    create_table :user_follow_ships do |t|
      t.references :user
      t.references :follow
      t.timestamps
    end
  end
end
