class SleepRecordRepository < ApplicationRepository
  class << self
    def create(params)
      new_sleep_record = ::SleepRecord.create(params)
      if !new_sleep_record.valid?
        raise ActiveRecord::RecordInvalid
      end
      new_sleep_record
    end

    def get_last_by_user_id(user_id)
      ::SleepRecord.where(user_id: user_id).order(clock_in_time: :desc).first
    end

    def find_by_user_id(user_id)
      ::SleepRecord.where(user_id: user_id).order(clock_in_time: :desc)
    end
  end
end
