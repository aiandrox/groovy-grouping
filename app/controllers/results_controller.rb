class ResultsController < ApplicationController
  def create
    @event = Event.find_by!(ref_uuid: params[:event_ref_uuid])
    if setting_statuses?(@event)
      Result.group(@event)
    else
      redirect_to request.referer, alert: '条件が未設定の参加者がいます'
    end
    # attendances = @event.attendances.joins(attendance_statuses: :criterion_status)
    # attendance_statuses = AttendanceStatus.joins(:criterion, :criterion_status).where(criterion: { event_id: @event.id })
    # attendance_statuses_hash = attendance_statuses.group_by(&:criterion_id)
    # @event.criteria.order_by(:priority).each do |criterion|
    #   attendance_statuses = attendance_statuses_hash[criterion.id]
    # end
  end

  def setting_statuses?(event)
    event.attendances.joins(:attendance_statuses).count === event.criteria.count * event.attendances.count
  end
end
