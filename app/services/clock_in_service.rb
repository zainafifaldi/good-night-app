class ClockInService < ApplicationService
  def self.clock_in(params)
    last_sleep_session = ::SleepRecordRepository.get_last_by_user_id(params[:user_id])
    raise "Active sleep session exists" if last_sleep_session.present? && last_sleep_session.wake_up_time.nil?

    ::SleepRecordRepository.create({
      user_id: params[:user_id],
      clock_in_time: params[:clock_in_time]
    })
  end

  def self.get_all_clock_in_user(user_id)
    ::SleepRecordRepository.find_by_user_id(user_id).to_a
  end
end
