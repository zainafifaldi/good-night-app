class Follow < ApplicationRecord
  validates :follower_id, presence: true
end
