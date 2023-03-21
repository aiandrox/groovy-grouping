class TeamsController < ApplicationController
  before_action :set_editable_team, only: %i[edit update destroy]

  def show
    @team = Team.find_by!(ref_uuid: params[:ref_uuid])
  end

  def new
    @team = Team.new
  end

  def edit
    @event = @team.events.build
    @events = Event.where(team: @team)
  end

  def create
    @team = Team.new(team_params)

    if @team.save
      @team.events.create!(name: @team.name, group_count: 1)
      redirect_to edit_team_path(@team), notice: 'Team was successfully created.'
    else
      render :new
    end
  end

  def update
    if @team.update(team_params)
      redirect_to edit_team_path(@team), notice: 'Team was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @team.destroy!
    redirect_to root_path, notice: 'Team was successfully destroyed.'
  end

  private

  def set_editable_team
    @team = Team.find_by!(edit_uuid: params[:edit_uuid])
  end

  def team_params
    params.require(:team).permit(:name)
  end
end
