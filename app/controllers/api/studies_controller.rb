class Api::StudiesController < ApplicationController
  protect_from_forgery except: [:index, :create, :update, :destroy]

  before_action :set_study, only: [:show]

  rescue_from Exception, with: :render_status_500

  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  def index
    # todo currentUserロジック
    # todo currentUserの今週日曜日~土曜日までのデータを取得する
    studies = Study.this_week_total
    # studies = Study.all
    render json: studies
  end

  def create
    study = Study.new(study_params)
    if study.save
      render json: study, status: :created
    else
      render json: { errors: study.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: @study
  end

  private

  def set_study
    @study = Study.find(params[:id])
  end

  def study_params
    params.fetch(:study, {}).permit(:time, :total)
  end

  def render_status_404(exception)
    render json: { errors: [exception] }, status: 404
  end

  def render_status_500(exception)
    render json: { errors: [exception] }, status: 500
  end
end