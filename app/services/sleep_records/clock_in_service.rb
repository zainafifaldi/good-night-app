module SleepRecords
  class ClockInService < ApplicationService
    attr_reader :sleep_record_params

    def initialize(sleep_record_params)
      @sleep_record_params = sleep_record_params
    end

    def call
      check_last_sleep_session
      create_sleep_record
    end

    private

    def check_last_sleep_session
      last_sleep_session = ::SleepRecordRepository.get_last_by_user_id(@sleep_record_params[:user_id])

      raise "Active sleep session exists" if last_sleep_session.present? && last_sleep_session.wake_up_time.nil?
    end

    def create_sleep_record
      ::SleepRecordRepository.create({
        user_id: @sleep_record_params[:user_id],
        clock_in_time: @sleep_record_params[:clock_in_time]
      })
    end
  end
end
