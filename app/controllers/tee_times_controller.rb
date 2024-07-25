class TeeTimesController < ApplicationController
  def index
    @q = TeeTime.ransack(params[:q])
    @all_tee_times = @q.result(distinct: true).count
    @tee_times = @q.result(distinct: true).page(params[:page]).per(20)
  end

  def show
    @tee_time = TeeTime.find(params[:id])
  end
end
