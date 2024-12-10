class FollowRepository < ApplicationRepository
  REDIS_KEY_USER_FOLLOWINGS = "users:sets_following:".freeze

  class << self
    def create(params)
      new_follow = ::Follow.create(params)
      if !new_follow.valid?
        raise ActiveRecord::RecordInvalid
      end

      # Update cache user followings
      if REDIS.exists?("#{::FollowRepository::REDIS_KEY_USER_FOLLOWINGS}#{params[:follower_id]}")
        REDIS.sadd("#{::FollowRepository::REDIS_KEY_USER_FOLLOWINGS}#{params[:follower_id]}", params[:followee_id])
      end

      new_follow
    end

    def delete(user_follow)
      REDIS.srem("#{::FollowRepository::REDIS_KEY_USER_FOLLOWINGS}#{user_follow.follower_id}", user_follow.followee_id)

      user_follow.delete
    end

    def get_follower_followee(follower_id, followee_id)
      ::Follow.where(follower_id: follower_id, followee_id: followee_id).first
    end

    def get_list_following_ids(follower_id)
      # Read from cache if exist
      following_ids = REDIS.smembers("#{::FollowRepository::REDIS_KEY_USER_FOLLOWINGS}#{follower_id}")
      return following_ids if following_ids.present?

      # Select from database and set cache
      following_ids = ::Follow.where(follower_id: follower_id).map(&:followee_id)
      REDIS.sadd("#{::FollowRepository::REDIS_KEY_USER_FOLLOWINGS}#{follower_id}", following_ids)

      following_ids
    end
  end
end
