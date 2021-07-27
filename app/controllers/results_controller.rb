class ResultsController < ApplicationController
  def create
    @event = Event.find_by!(ref_uuid: params[:event_ref_uuid])
    if @event.setting_statuses?
      result = Result.group(@event)
      redirect_to event_result_path(@event.ref_uuid, result)
    else
      redirect_to request.referer, alert: '条件が未設定の参加者がいます'
    end
  end

  def show
    @event = Event.find_by!(ref_uuid: params[:event_ref_uuid])
    @result = @event.results.find_by!(uuid: params[:uuid])
  end
end
