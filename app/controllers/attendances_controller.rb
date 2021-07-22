class AttendancesController < ApplicationController
  before_action :set_editable_event

  def create
    @attendance = @event.attendances.build(attendance_params)

    if @attendance.save
      redirect_to edit_event_path(@event), notice: '参加者を追加しました'
    else
      render 'events/edit'
    end
  end

  def destroy
    @attendance = @event.attendances.find(params[:id])
    @attendance.destroy!
    redirect_to edit_event_path(@event), notice: '参加者から外しました'
  end

  private

  def set_editable_event
    @event = Event.find_by!(edit_uuid: params[:event_edit_uuid])
  end

  def attendance_params
    params.require(:attendance).permit(
      :user_id,
      attendance_statuses_attributes: [
        :criterion_id,
        :attendance_id,
        :criterion_status_id,
      ]
    )
  end
end
