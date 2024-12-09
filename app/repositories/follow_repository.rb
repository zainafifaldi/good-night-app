class FollowRepository < ApplicationRepository
  class << self
    def create(params)
      new_follow = ::Follow.create(params)
      if !new_follow.valid?
        raise ActiveRecord::RecordInvalid
      end
      new_follow
    end

    def delete(user_follow)
      user_follow.delete
    end

    def get_follower_followee(follower_id, followee_id)
      ::Follow.where(follower_id: follower_id, followee_id: followee_id).first
    end

    def find_by_follower_id(follower_id)
      ::Follow.where(follower_id: follower_id).all
    end
  end
end
