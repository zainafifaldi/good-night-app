module SleepRecords
  class FollowingHistoryService < ApplicationService
    attr_reader :user_id

    def initialize(user_id)
      @user_id = user_id
    end

    def call
      followings = get_followings
      get_last_weeks_sleep_records(followings)
    end

    private

    def get_followings
      ::FollowRepository.find_by_follower_id(@user_id)
    end

    def get_last_weeks_sleep_records(followings)
      ::SleepRecordRepository.find_last_week_by_users_order_by_duration(followings.map(&:followee_id))
    end
  end
end
