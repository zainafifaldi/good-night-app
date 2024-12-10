class AddIndexUserCreatedatOnSleepHistory < ActiveRecord::Migration[8.0]
  def change
    add_index :sleep_records, [ :user_id, :created_at ]
  end
end
