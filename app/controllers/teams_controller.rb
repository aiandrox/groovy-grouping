class TeamsController < ApplicationController
  def show
    @team = Team.find_by!(ref_uuid: params[:ref_uuid])
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
    @team = Team.find_by!(edit_uuid: params[:edit_uuid])
  end

  # POST /teams
  def create
    @team = Team.new(team_params)

    if @team.save
      @team.events.create!(name: @team.name)
      redirect_to edit_team_path(@team.edit_uuid), notice: 'Team was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /teams/1
  def update
    @team = Team.find_by!(edit_uuid: params[:edit_uuid])
    if @team.update(team_params)
      redirect_to edit_team_path(@team.edit_uuid), notice: 'Team was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /teams/1
  def destroy
    @team = Team.find_by!(edit_uuid: params[:edit_uuid])
    @team.destroy!
    redirect_to root_path, notice: 'Team was successfully destroyed.'
  end

  private

  # Only allow a list of trusted parameters through.
  def team_params
    params.require(:team).permit(:name)
  end
end
