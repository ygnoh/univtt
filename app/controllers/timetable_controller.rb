class TimetableController < ApplicationController
  def index
  end

  def new
		@samples = [{lecture_name: "선형대수1", time: [1000,1300], day: ["wed"], prof_name: "민강주"}, {lecture_name: "선형대수2", time: [1200,1330], day: ["fri"], prof_name: "안재현"}]
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
