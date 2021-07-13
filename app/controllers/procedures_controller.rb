class ProceduresController < ApplicationController
  before_action :set_procedure, only: %i[edit update destroy]

  def index
    @posts = Procedure.where(team_id: current_member.team.id).order(id: :desc) if member_signed_in?
    @posts = Procedure.where(team_id: current_admin.team.id).order(id: :desc) if admin_signed_in?
  end

  def show
    @procedure = Procedure.find(params[:id])
  end

  def new
    @procedure = current_member.procedures.build
  end

  def create
    @procedure = current_member.procedures.build(procedure_params)
    @procedure.team_id = current_member.team_id

    if @procedure.save
      redirect_to users_procedure_path(@procedure), notice: 'Procedure was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @procedure.update(procedure_params)
      redirect_to users_procedure_path(@procedure), notice: 'Procedure was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @procedure.destroy
    redirect_to users_procedures_path, notice: 'Procedure was successfully destroyed.'
  end

  private

  def set_procedure
    @procedure = current_member.procedures.find(params[:id])
  end

  def procedure_params
    params.require(:procedure).permit(:title, :body)
  end
end
