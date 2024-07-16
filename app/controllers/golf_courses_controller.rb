class GolfCoursesController < ApplicationController
  def index
    @courses = GolfCourse.all
  end

  def show
    @golf_course = GolfCourse.find(params[:id])
    @tee_times = @golf_course.tee_times.page(params[:page]).per(20)
  end
end
