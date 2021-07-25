class ResultsController < ApplicationController
  def create
    @event = Event.find_by!(ref_uuid: params[:event_ref_uuid])
    if setting_statuses?(@event)
      Result.group(@event)
    else
      redirect_to request.referer, alert: '条件が未設定の参加者がいます'
    end
  end

  def show
    @event = Event.find_by!(ref_uuid: params[:event_ref_uuid])
    @result = @event.results.find_by!(uuid: params[:uuid])
  end

  def setting_statuses?(event)
    event.attendances.joins(:attendance_statuses).count === event.criteria.count * event.attendances.count
  end
end
