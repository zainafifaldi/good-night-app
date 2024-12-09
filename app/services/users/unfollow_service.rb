module Users
  class UnfollowService < ApplicationService
    attr_reader :unfollow_params

    def initialize(unfollow_params)
      @unfollow_params = unfollow_params
    end

    def call
      user_follow = get_user_follow
      remove_follow(user_follow)
    end

    private

    def get_user_follow
      user_follow = ::FollowRepository.get_follower_followee(@unfollow_params[:follower_id], @unfollow_params[:followee_id])

      raise "Follow does not exist" unless user_follow.present?

      user_follow
    end

    def remove_follow(user_follow)
      ::FollowRepository.delete(user_follow)
    end
  end
end
