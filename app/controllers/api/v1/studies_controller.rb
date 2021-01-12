class Api::V1::StudiesController < ApplicationController
  protect_from_forgery except: [:index, :create, :update, :destroy]

  before_action :authorize_access_request!

  rescue_from Exception, with: :render_status_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  def index
    studies = current_user.studies.this_week_total
    render json: studies
  end

  def create
    study = current_user.studies.new(study_params)
    # srudy = Study.new(study_params)
    if study.save
      render json: study, status: :created
    else
      render json: study.errors, status: :unprocessable_entity
    end
  end

  private

  def study_params
    params.require(:study).permit(:time, :total, :user_id)
  end

  def render_status_404(exception)
    render json: { errors: [exception] }, status: 404
  end

  def render_status_500(exception)
    render json: { errors: [exception] }, status: 500
  end
end