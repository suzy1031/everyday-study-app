class Api::V1::StudiesController < ApplicationController
  protect_from_forgery except: [:index, :history, :create, :update, :destroy]

  before_action :authorize_access_request!

  rescue_from Exception, with: :render_status_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  def index
    studies = current_user.studies.this_week_total
    render json: studies
  end

  def history
    histories = current_user.studies.get_week_chart_data
    render json: histories
  end

  def create
    study = Study.new(study_params)
    if study.save
      render json: study, status: :created
    else
      render json: study.errors, status: :unprocessable_entity
    end
  end

  private

  def study_params
    params.require(:study).permit(:time, :total).merge(user_id: current_user.id)
  end

  def render_status_404(exception)
    render json: { errors: [exception] }, status: 404
  end

  def render_status_500(exception)
    render json: { errors: [exception] }, status: 500
  end
end