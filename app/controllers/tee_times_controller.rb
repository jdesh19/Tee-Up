class TeeTimesController < ApplicationController
  def index
    @tee_times = TeeTime.page(params[:page]).per(49)
  end
end
