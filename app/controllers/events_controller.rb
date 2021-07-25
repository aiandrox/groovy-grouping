class EventsController < ApplicationController
  before_action :set_editable_team, only: %i[new create]
  before_action :set_editable_event, only: %i[edit update destroy]

  def new
    @event = @team.events.build
  end

  def create
    @event = @team.events.build(event_params)

    if @event.save
      redirect_to edit_event_path(@event), notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  def show
    @event = Event.find_by!(ref_uuid: params[:ref_uuid])
  end

  def edit; end

  def update
    if @event.update(event_params)
      redirect_to edit_event_path(@event), notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @event.destroy!
    redirect_to root_path, notice: 'Event was successfully destroyed.'
  end

  private

  def set_editable_team
    @team = Team.find_by!(edit_uuid: params[:team_edit_uuid])
  end

  def set_editable_event
    @event = Event.find_by!(edit_uuid: params[:edit_uuid])
  end

  def event_params
    params.require(:event).permit(:name, :group_count)
  end
end
