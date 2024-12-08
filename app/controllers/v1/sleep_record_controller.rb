class V1::SleepRecordController < ApplicationController
  def clock_in
    ::ClockInService.clock_in(clock_in_params)

    sleep_records = ::ClockInService.get_all_clock_in_user(params[:user_id])

    render_json sleep_records, ::ClockInSerializer
  rescue => e
    render json: { errors: e }, status: :unprocessable_entity
  end

  private

  def clock_in_params
    params[:clock_in_time] = Time.at(params[:clock_in_time_unix]).to_datetime
    params.permit(:user_id, :clock_in_time)
  end
end
