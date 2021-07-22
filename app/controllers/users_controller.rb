class UsersController < ApplicationController
  before_action :set_editable_team

  def create
    @user = @team.users.build(user_params)

    if @user.save
      redirect_to edit_team_path(@team.edit_uuid), notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @user = @team.users.find(params[:id])
    @user.destroy!
    redirect_to edit_team_path(@team.edit_uuid), notice: 'User was successfully destroyed.'
  end

  private

  def set_editable_team
    @team = Team.find_by!(edit_uuid: params[:team_edit_uuid])
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
