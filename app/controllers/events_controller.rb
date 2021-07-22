class EventsController < ApplicationController
  def show
    @event = Event.find_by!(ref_uuid: params[:ref_uuid])
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find_by!(edit_uuid: params[:edit_uuid])
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      @event.events.create!(name: @event.name)
      redirect_to edit_event_path(@event.edit_uuid), notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  def update
    @event = Event.find_by!(edit_uuid: params[:edit_uuid])
    if @event.update(event_params)
      redirect_to edit_event_path(@event.edit_uuid), notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find_by!(edit_uuid: params[:edit_uuid])
    @event.destroy!
    redirect_to root_path, notice: 'Event was successfully destroyed.'
  end

  private

  def event_params
    params.require(:event).permit(:name)
  end
end
