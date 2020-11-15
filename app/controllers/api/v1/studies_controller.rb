class Api::V1::StudiesController < ApiController
  before_action :set_study, only: [:show]

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    studies = Study.all
    render json: studies
  end

  def show
    render json: @study
  end

  private

  def set_study
    @study = Study.find(params[:id])
  end
end