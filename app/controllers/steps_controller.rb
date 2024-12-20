class StepsController < ApplicationController
  before_action :set_goal
  before_action :set_step, only: [:show, :edit, :update, :destroy]

  def new
    @step = @goal.steps.new
  end

  def create
    @step = @goal.steps.new(step_params)
    if @step.save
      redirect_to goal_path(@goal), notice: "Étape créée avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @step.update(step_params)
      redirect_to goal_path(@goal), notice: "Étape mise à jour avec succès."
    else
      render :edit, status: :unprocessable_entity
    end
  end

   def destroy
    @step.destroy
    redirect_to goal_path(@goal), notice: "Étape supprimée avec succès."
  end


  private

  def set_goal
    @goal = Goal.find_by(id: params[:goal_id])
    redirect_to goals_path, alert: "Objectif introuvable." unless @goal
  end

  def set_step
    @step = @goal.steps.find_by(id: params[:id])
    redirect_to goal_path(@goal), alert: "Étape introuvable." unless @step
  end

  def step_params
    params.require(:step).permit(:title, :description)
  end
end
