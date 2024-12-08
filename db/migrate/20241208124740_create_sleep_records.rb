class CreateSleepRecords < ActiveRecord::Migration[8.0]
  def change
    create_table :sleep_records do |t|
      t.bigint :user_id, null: false
      t.datetime :clock_in_time
      t.datetime :wake_up_time
      t.unsigned_integer :total_sleep_time

      t.timestamps
    end

    add_index :sleep_records, [ :user_id, :clock_in_time ]
  end
end
