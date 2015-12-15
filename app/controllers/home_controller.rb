class HomeController < ApplicationController
  def index
		@savetts = Savetimetable.all.count
  end
end
