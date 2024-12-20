class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy]

  def index
    @goals = Goal.all
  end

  def show
    @steps = @goal.steps
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    if @goal.save
      redirect_to @goal, notice: "Objectif créé avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @goal.update(goal_params)
      redirect_to @goal, notice: "Objectif mis à jour avec succès."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @goal.destroy
    redirect_to goals_path, notice: "Objectif supprimé avec succès."
  end

  private

  def set_goal
    @goal = Goal.find_by(id: params[:id])
    redirect_to goals_path, alert: "Objectif introuvable." unless @goal
  end

  def goal_params
    params.require(:goal).permit(:title)
  end
end
