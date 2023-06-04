class CreateUserSleepDiaries < ActiveRecord::Migration[7.0]
  def change
    create_table :user_sleep_diaries do |t|
      t.references :user_sleep_meta
      t.integer :status, default: 0
      t.date :record_date, notnull: true, index: true
      t.integer :total_sleep_minute, default: 0
      t.datetime :bed_time
      t.datetime :wake_time
      t.integer :bed_time_record_id, index: true
      t.integer :wake_time_record_id, index: true
      t.timestamps
    end
  end
end
