module SleepRecords
  class WakeUpService < ApplicationService
    attr_reader :sleep_record_params

    def initialize(sleep_record_params)
      @sleep_record_params = sleep_record_params
    end

    def call
      sleep_record = get_last_sleep_session
      update_sleep_record(sleep_record)
    end

    private

    def get_last_sleep_session
      last_sleep_session = ::SleepRecordRepository.get_last_by_user_id(@sleep_record_params[:user_id])

      raise "Sleep session does not exist" if !allowed_to_wake_up?(last_sleep_session)

      last_sleep_session
    end

    def allowed_to_wake_up?(sleep_record)
      sleep_record.present? && sleep_record.clock_in_time.present? && sleep_record.wake_up_time.nil?
    end

    def update_sleep_record(sleep_record)
      ::SleepRecordRepository.update(sleep_record, {
        wake_up_time: @sleep_record_params[:wake_up_time],
        total_sleep_time: calculate_total_sleep_time(sleep_record)
      })
    end

    def calculate_total_sleep_time(sleep_record)
      ((Time.parse(@sleep_record_params[:wake_up_time].to_s) - Time.parse(sleep_record.clock_in_time.to_s)) / 60).to_i
    end
  end
end
