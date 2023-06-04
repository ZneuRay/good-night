class CreateUserSleepMeta < ActiveRecord::Migration[7.0]
  def change
    create_table :user_sleep_meta do |t|
      t.references :user
      t.integer :user_sleep_diary_count, default: 0
      t.boolean :disabled, default: false
      t.timestamps
    end
  end
end
