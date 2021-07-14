class ProceduresController < ApplicationController
  before_action :set_procedure, only: %i[edit update destroy approve]

  def index
    @q = Procedure.where(team_id: current_member.team.id).where(approved: true).order(id: :desc).ransack(params[:q]) if member_signed_in?
    @q = Procedure.where(team_id: current_admin.team.id).order(id: :desc).ransack(params[:q]) if admin_signed_in?

    @posts = @q.result(distinct: true)
  end

  def show
    @procedure = Procedure.find(params[:id])
  end

  def new
    @procedure = current_member.procedures.build if member_signed_in?
    @procedure = current_admin.procedures.build if admin_signed_in?
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
    redirect_to root_path, notice: "Procedure has been successfully updated. #{params[:id]}" if @procedure.save
  end

  private

  def set_procedure
    @procedure = current_member.procedures.find(params[:id]) if member_signed_in?
    @procedure = Procedure.find(params[:id]) if admin_signed_in?
  end

  def procedure_params
    params.require(:procedure).permit(:title, :body)
  end
end
