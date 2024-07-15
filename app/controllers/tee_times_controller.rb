class TeeTimesController < ApplicationController
  def index
    @tee_times = TeeTime.page(params[:page]).per(49)
  end

  def show
    @tee_time = TeeTime.find(params[:id])
  end
end
