class TeamsController < ApplicationController
  def show
    @team = Team.find_by!(ref_uuid: params[:ref_uuid])
  end

  def new
    @team = Team.new
  end

  def edit
    @team = Team.find_by!(edit_uuid: params[:edit_uuid])
  end

  def create
    @team = Team.new(team_params)

    if @team.save
      @team.events.create!(name: @team.name)
      redirect_to edit_team_path(@team.edit_uuid), notice: 'Team was successfully created.'
    else
      render :new
    end
  end

  def update
    @team = Team.find_by!(edit_uuid: params[:edit_uuid])
    if @team.update(team_params)
      redirect_to edit_team_path(@team.edit_uuid), notice: 'Team was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @team = Team.find_by!(edit_uuid: params[:edit_uuid])
    @team.destroy!
    redirect_to root_path, notice: 'Team was successfully destroyed.'
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end
end
