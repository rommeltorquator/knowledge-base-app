class AccountController < ApplicationController
  def new
    @new_user = User.new
  end

  def create
    # @new_user = User.new(email: params[:user][:email], first_name: params[:user][:first_name], last_name: params[:user][:last_name], type: params[:user][:type], password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])

    @new_user = User.new(
      email: params[:user][:email],
      first_name: params[:user][:first_name], 
      last_name: params[:user][:last_name], 
      password: params[:user][:password],
      password_confirmation: params[:user][:password_confirmation])

    @new_user.type = 'Member'
    @new_user.team_id = current_admin.team_id

    # byebug
    if @new_user.save
      redirect_to root_path, notice: 'Procedure was successfully created.'
    else
      render "new"
    end
  end
end
