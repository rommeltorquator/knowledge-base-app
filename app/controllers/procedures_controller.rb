class ProceduresController < ApplicationController
  before_action :set_procedure, only: %i[edit update destroy approve]

  def index
    @q = all_procedures

    @posts = @q.result(distinct: true)
  end

  def show
    @procedure = Procedure.friendly.find(params[:id])

    base_url = 'https://www.googleapis.com/youtube/v3/'
    max_results = 3
    response = RestClient.get("#{base_url}search?maxResults=#{max_results}&q=#{@procedure.title}&key=#{ENV['KEY']}")
    @videos = JSON.parse(response)
  end

  def new
    @procedure = new_procedure
  end

  def create
    if member_signed_in?
      @procedure = current_member.procedures.build(procedure_params)
      @procedure.team_id = current_member.team_id
    elsif admin_signed_in?
      @procedure = current_admin.procedures.build(procedure_params)
      @procedure.approved = true
      @procedure.team_id = current_admin.team_id
    end

    if @procedure.save
      redirect_to procedure_path(@procedure), notice: 'Procedure was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @procedure.update(procedure_params)
      redirect_to procedure_path(@procedure), notice: 'Procedure was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @procedure.destroy
    redirect_to procedures_path, notice: 'Procedure was successfully destroyed.'
  end

  def approve
    @procedure.approved = true
    ProcedureMailer.with(email: @procedure.user.email, procedure: @procedure, admin: current_admin).approved_procedure.deliver_now
    redirect_to root_path, notice: "Procedure has been successfully updated. #{params[:id]}" if @procedure.save
  end

  private

  def new_procedure
    return current_member.procedures.build if member_signed_in?
    return current_admin.procedures.build if admin_signed_in?
  end

  def all_procedures
    return Procedure.where(team_id: current_member.team.id).where(approved: true).order(id: :desc).ransack(params[:q]) if member_signed_in?

    return Procedure.where(team_id: current_admin.team.id).order(id: :desc).ransack(params[:q]) if admin_signed_in?
  end

  def set_procedure
    @procedure = current_member.procedures.friendly.find(params[:id]) if member_signed_in?
    @procedure = Procedure.friendly.find(params[:id]) if admin_signed_in?
  end

  def procedure_params
    params.require(:procedure).permit(:title, :body)
  end
end
