class SleepRecordSerializer < ActiveModel::Serializer
  attributes :user_id,
             :clock_in_time_unix,
             :wake_up_time_unix,
             :total_sleep_time

  def clock_in_time_unix
    object.clock_in_time&.to_i
  end

  def wake_up_time_unix
    object.wake_up_time&.to_i
  end
end
