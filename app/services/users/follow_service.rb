module Users
  class FollowService < ApplicationService
    attr_reader :follow_params

    def initialize(follow_params)
      @follow_params = follow_params
    end

    def call
      existing_follow = get_existing_follow
      return existing_follow if existing_follow.present?

      create_follow
    end

    private

    def get_existing_follow
      ::FollowRepository.get_follower_followee(@follow_params[:follower_id], @follow_params[:followee_id])
    end

    def create_follow
      ::FollowRepository.create({
        follower_id: @follow_params[:follower_id],
        followee_id: @follow_params[:followee_id]
      })
    end
  end
end
