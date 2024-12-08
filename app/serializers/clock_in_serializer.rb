class ClockInSerializer < ActiveModel::Serializer
  attributes :clock_in_time_unix

  def clock_in_time_unix
    object.clock_in_time.to_i
  end
end
