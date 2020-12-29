class Api::V1::GoalsController < ApplicationController
  protect_from_forgery except: [:index, :create, :update, :destroy]

  before_action :authorize_access_request!

  rescue_from Exception, with: :render_status_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  def create
    goal = current_user.goals.build(goal_params)
    if goal.save
      render json: goal, status: :created
    else
      render json: goal.errors, status: :unprocessable_entity
    end
  end

  def update
    @goal = current_user.goals.find(params[:id])
    @goal.update!(goal_params)
    render json: @goal
  end

  private

  def goal_params
    params.require(:goal).permit(:target_time, :user_id)
  end

  def render_status_404(exception)
    render json: { errors: [exception] }, status: 404
  end

  def render_status_500(exception)
    render json: { errors: [exception] }, status: 500
  end
end