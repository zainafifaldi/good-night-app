class CreateFollows < ActiveRecord::Migration[8.0]
  def change
    create_table :follows do |t|
      t.bigint :follower_id, null: false
      t.bigint :followee_id, null: false

      t.timestamps
    end

    add_index :follows, :follower_id
  end
end
