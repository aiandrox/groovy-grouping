class UsersController < ApplicationController
  before_action :set_editable_team

  def create
    @user = User.new(**user_params, team: @team)

    if @user.save
      redirect_to edit_team_path(@team), notice: 'User was successfully created.'
    else
      flash.now[:alert] = @user.errors.full_messages.join
      render 'teams/edit'
    end
  end

  def destroy
    @user = @team.users.find(params[:id])
    @user.deactive!
    redirect_to edit_team_path(@team), notice: 'User was successfully destroyed.'
  end

  private

  def set_editable_team
    @team = Team.find_by!(edit_uuid: params[:team_edit_uuid])
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
