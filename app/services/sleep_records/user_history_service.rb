module SleepRecords
  class UserHistoryService < ApplicationService
    attr_reader :user_id

    def initialize(user_id)
      @user_id = user_id
    end

    def call
      ::SleepRecordRepository.find_by_user_id(@user_id).to_a
    end
  end
end
