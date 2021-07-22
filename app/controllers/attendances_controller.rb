class AttendancesController < ApplicationController
  def create
    @event = Event.find_by!(edit_uuid: params[:event_edit_uuid])
    @attendance = @event.attendances.build(attendance_params)

    if @attendance.save
      redirect_to edit_event_path(@event.edit_uuid), notice: '参加者を追加しました'
    else
      render 'events/edit'
    end
  end

  def destroy
    @event = Event.find_by!(edit_uuid: params[:event_edit_uuid])
    @attendance = @event.attendances.find(params[:id])
    @attendance.destroy!
    redirect_to edit_event_path(@event.edit_uuid), notice: '参加者から外しました'
  end

  private

  def attendance_params
    params.require(:attendance).permit(:user_id)
  end
end
