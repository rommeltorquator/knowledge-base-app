class ProceduresController < ApplicationController
  before_action :set_procedure, only: %i[show edit update destroy]

  def index
    @procedures = current_user.procedures.all
  end

  def show; end

  def new
    @procedure = Procedure.new
  end

  def create
    @procedure = current_user.procedures.build(procedure_params)
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
    @procedure = current_user.procedures.find(params[:id])
  end

  def procedure_params
    params.require(:procedure).permit(:title, :body)
  end
end
