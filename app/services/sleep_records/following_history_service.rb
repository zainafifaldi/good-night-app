module SleepRecords
  class FollowingHistoryService < ApplicationService
    attr_reader :user_id

    def initialize(user_id)
      @user_id = user_id
    end

    def call
      following_ids = get_following_ids
      get_last_weeks_sleep_records(following_ids)
    end

    private

    def get_following_ids
      ::FollowRepository.get_list_following_ids(@user_id)
    end

    def get_last_weeks_sleep_records(following_ids)
      ::SleepRecordRepository.find_last_week_by_users_order_by_duration(following_ids)
    end
  end
end
