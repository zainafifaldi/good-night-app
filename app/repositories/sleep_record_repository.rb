class SleepRecordRepository < ApplicationRepository
  class << self
    def create(params)
      if !::SleepRecord.create(params).valid?
        raise ActiveRecord::RecordInvalid
      end
    end

    def get_last_by_user_id(user_id)
      ::SleepRecord.where(user_id: user_id).order(clock_in_time: :desc).first
    end

    def find_by_user_id(user_id)
      ::SleepRecord.where(user_id: user_id).order(clock_in_time: :desc)
    end
  end
end
