class CreateUserSleepRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :user_sleep_records do |t|
      t.references :user_sleep_diary
      t.datetime :start_time
      t.datetime :end_time
      t.integer :state, default: 0
      t.integer :total_sleep_minute, default: 0
      t.datetime :record_time
      t.timestamps
    end
  end
end
