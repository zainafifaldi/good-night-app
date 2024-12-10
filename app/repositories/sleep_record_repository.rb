class SleepRecordRepository < ApplicationRepository
  REDIS_KEY_USER_HISTORY = "users:sleep_record_history:".freeze
  REDIS_KEY_USER_HISTORY_LAST_WEEK = "users:sleep_record_history_last_week:".freeze

  class << self
    def create(params)
      new_sleep_record = ::SleepRecord.create(params)
      if !new_sleep_record.valid?
        raise ActiveRecord::RecordInvalid
      end

      # Set cache user sleep history
      sleep_history_str = REDIS.get("#{::SleepRecordRepository::REDIS_KEY_USER_HISTORY}#{params[:user_id]}")
      if sleep_history_str.present?
        serialized_sleep_history = JSON.parse(sleep_history_str)
        serialized_sleep_history = serialized_sleep_history.unshift(new_sleep_record.serializable_hash)
        REDIS.set("#{::SleepRecordRepository::REDIS_KEY_USER_HISTORY}#{params[:user_id]}", serialized_sleep_history.to_json, ex: 1.day)
      end

      # Invalidate cache user sleep history last week
      REDIS.del("#{::SleepRecordRepository::REDIS_KEY_USER_HISTORY_LAST_WEEK}#{params[:user_id]}")

      new_sleep_record
    end

    def update(sleep_record, params)
      sleep_record.update(params)

      # Invalidate cache user sleep history
      REDIS.del("#{::SleepRecordRepository::REDIS_KEY_USER_HISTORY}#{sleep_record.user_id}")

      # Invalidate cache user sleep history last week
      REDIS.del("#{::SleepRecordRepository::REDIS_KEY_USER_HISTORY_LAST_WEEK}#{params[:user_id]}")

      sleep_record
    end

    def get_last_by_user_id(user_id)
      ::SleepRecord.where(user_id: user_id).order(clock_in_time: :desc).first
    end

    def find_by_user_id(user_id)
      # Read from cache if exist
      sleep_history_str = REDIS.get("#{::SleepRecordRepository::REDIS_KEY_USER_HISTORY}#{user_id}")
      if sleep_history_str.present?
        serialized_sleep_history = JSON.parse(sleep_history_str)
        sleep_history = serialized_sleep_history.map { |attributes| ::SleepRecord.new(attributes) }
        return sleep_history
      end

      # Select from database and set cache
      sleep_history = ::SleepRecord.where(user_id: user_id).order(created_at: :desc).to_a
      REDIS.set("#{::SleepRecordRepository::REDIS_KEY_USER_HISTORY}#{user_id}", sleep_history.to_json, ex: 1.day)

      sleep_history
    end

    def find_last_week_by_users_order_by_duration(user_ids)
      all_sleep_history = []
      user_ids.each do |user_id|
        sleep_history = find_last_week_by_a_user_order_by_duration(user_id)
        next if sleep_history.empty?

        all_sleep_history = all_sleep_history.concat(sleep_history)
      end

      all_sleep_history.sort_by { |sr| -sr.total_sleep_time } # giving "-" to sort in descending
    end

    def find_last_week_by_a_user_order_by_duration(user_id)
      @past_week_time ||= Time.now - 7.days

      # Read from cache if exist
      sleep_history_str = REDIS.get("#{::SleepRecordRepository::REDIS_KEY_USER_HISTORY_LAST_WEEK}#{user_id}")
      if sleep_history_str.present?
        serialized_sleep_history = JSON.parse(sleep_history_str)
        sleep_history = serialized_sleep_history.map { |attributes| ::SleepRecord.new(attributes) }
        return sleep_history
      end

      # Select from database and set cache
      sleep_history = ::SleepRecord.where(user_id: user_id).where("clock_in_time > '#{@past_week_time}'").where.not(total_sleep_time: nil).order(total_sleep_time: :desc).to_a
      return sleep_history if sleep_history.empty?

      shortest_remaining_time = 10080 # when sleep history will expired as past week (default 1 week)
      sleep_history.each do |sleep_record|
        remaining_time = ((Time.parse(sleep_record.clock_in_time.to_s) - Time.parse(@past_week_time.to_s)) / 60).to_i
        shortest_remaining_time = remaining_time if remaining_time < shortest_remaining_time
      end
      REDIS.set("#{::SleepRecordRepository::REDIS_KEY_USER_HISTORY}#{user_id}", sleep_history.to_json, ex: shortest_remaining_time.minutes)

      sleep_history
    end
  end
end
