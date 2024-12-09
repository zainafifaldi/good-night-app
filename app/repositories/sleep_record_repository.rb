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

    def find_last_week_by_users_order_by_duration(user_ids)
      past_week_time = Time.now - 7.days
      ::SleepRecord.where(user_id: user_ids).where.not(total_sleep_time: nil).where("created_at > '#{past_week_time}'").order(total_sleep_time: :desc).all.to_a
    end
  end
end
