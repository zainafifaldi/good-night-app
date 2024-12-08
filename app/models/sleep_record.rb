class SleepRecord < ApplicationRecord
  validates :user_id, presence: true
end
