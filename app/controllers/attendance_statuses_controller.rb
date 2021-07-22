class AttendanceStatusesController < ApplicationController
  def create
    @attendance_status = AttendanceStatus.new(attendance_status_params)
    @attendance_status.save!
  end

  def update
    @attendance_status = AttendanceStatus.find(params[:id])
    if attendance_status_params[:criterion_status_id].present?
      @attendance_status.update!(attendance_status_params)
    else
      @attendance_status.destroy!
    end
  end

  private

  def attendance_status_params
    params.require(:attendance_status).permit(:attendance_id, :criterion_id, :criterion_status_id)
  end
end
