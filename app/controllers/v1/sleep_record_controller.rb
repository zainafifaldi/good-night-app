class V1::SleepRecordController < ApplicationController
  def clock_in
    ::SleepRecords::ClockInService.call(clock_in_params)

    sleep_records = ::SleepRecords::UserHistoryService.call(params[:user_id])

    render_json sleep_records, ::SleepRecordSerializer
  rescue => e
    render json: { errors: e }, status: :unprocessable_entity
  end

  def wake_up
    ::SleepRecords::WakeUpService.call(wake_up_params)

    sleep_records = ::SleepRecords::UserHistoryService.call(params[:user_id])

    render_json sleep_records, ::SleepRecordSerializer
  rescue => e
    render json: { errors: e }, status: :unprocessable_entity
  end

  private

  def clock_in_params
    params[:clock_in_time] = Time.at(params[:clock_in_time_unix]).to_time
    params.permit(:user_id, :clock_in_time)
  end

  def wake_up_params
    params[:wake_up_time] = Time.at(params[:wake_up_time_unix]).to_time
    params.permit(:user_id, :wake_up_time)
  end
end
