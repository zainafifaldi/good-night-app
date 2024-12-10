class SleepRecordSerializer < ActiveModel::Serializer
  attributes :id,
             :user_id,
             :clock_in_time_unix,
             :wake_up_time_unix,
             :total_sleep_time,
             :created_at,
             :updated_at

  def clock_in_time_unix
    object.clock_in_time&.to_i
  end

  def wake_up_time_unix
    object.wake_up_time&.to_i
  end
end
