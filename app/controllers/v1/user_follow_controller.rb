class V1::UserFollowController < ApplicationController
  def follow
    user_follow = ::Users::FollowService.call(follow_params)

    render_json user_follow, ::FollowSerializer
  rescue => e
    render json: { errors: e }, status: :unprocessable_entity
  end

  def unfollow
    ::Users::UnfollowService.call(unfollow_params)

    render json: { message: "success" }, status: :ok
  rescue => e
    render json: { errors: e }, status: :unprocessable_entity
  end

  private

  def follow_params
    params.permit(:follower_id, :followee_id)
  end

  def unfollow_params
    params.permit(:follower_id, :followee_id)
  end
end
