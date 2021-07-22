class CriteriaController < ApplicationController
  before_action :set_editable_event

  def new
    @criterion = @event.criteria.build
  end

  def create
    @criterion = @event.criteria.build(criterion_params)

    if @criterion.save
      redirect_to edit_event_path(@event.edit_uuid), notice: 'Criterion was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @criterion = @event.criteria.find(params[:id])
    @criterion.destroy!
    redirect_to edit_event_path(@event.edit_uuid), notice: 'Criterion was successfully destroyed.'
  end

  private

  def set_editable_event
    @event = Event.find_by!(edit_uuid: params[:event_edit_uuid])
  end

  def criterion_params
    params.require(:criterion).permit(:name, :priority)
  end
end
