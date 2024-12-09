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

  def following_sleep_records
    sleep_records = ::SleepRecords::FollowingHistoryService.call(following_sleep_records_params[:user_id])

    render_json sleep_records, ::SleepRecordSerializer
  rescue => e
    render json: { errors: e }, status: :unprocessable_entity
  end

  private

  def follow_params
    params[:follower_id] = params[:user_id]
    params.permit(:follower_id, :followee_id)
  end

  def unfollow_params
    params[:follower_id] = params[:user_id]
    params.permit(:follower_id, :followee_id)
  end

  def following_sleep_records_params
    params.permit(:user_id)
  end
end
