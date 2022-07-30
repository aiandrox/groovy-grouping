class AttendanceStatusesController < ApplicationController
  before_action :set_instances

  def create
    @attendance_status = @attendance.attendance_statuses.build(attendance_status_params)
    @attendance_status.save
    redirect_to request.referer
  end

  def update
    @attendance_status = @attendance.attendance_statuses.find(params[:id])
    if attendance_status_params[:criterion_status_id].present?
      @attendance_status.update!(attendance_status_params)
    else
      @attendance_status.destroy!
    end
    redirect_to request.referer
  end

  private

  def set_instances
    @event = Event.find_by!(edit_uuid: params[:event_edit_uuid])
    @attendance = @event.attendances.find(attendance_status_params[:attendance_id])
  end

  def attendance_status_params
    params.require(:attendance_status).permit(:attendance_id, :criterion_status_id)
  end
end
