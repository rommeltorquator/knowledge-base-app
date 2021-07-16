class AccountController < ApplicationController
  def new
    @new_user = User.new
  end

  def create
    @new_user = User.new(user_params)
    @new_user.type = 'Member'
    @new_user.team_id = current_admin.team_id

    if @new_user.save
      redirect_to root_path, notice: 'Procedure was successfully created.'
    else
      render 'new'
    end
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end
end
