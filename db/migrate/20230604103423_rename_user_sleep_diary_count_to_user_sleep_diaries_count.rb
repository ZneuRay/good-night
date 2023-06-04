class RenameUserSleepDiaryCountToUserSleepDiariesCount < ActiveRecord::Migration[7.0]
  def up
    rename_column :user_sleep_meta, :user_sleep_diary_count, :user_sleep_diaries_count
  end

  def down
    rename_column :user_sleep_meta, :user_sleep_diaries_count, :user_sleep_diary_count
  end
end
