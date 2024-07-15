class GolfCoursesController < ApplicationController
  def index
    @courses = GolfCourse.all
  end

  def show
    @course = GolfCourse.find(param[:id])
  end
end
