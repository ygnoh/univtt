class HomeController < ApplicationController
  def index
		@savetts = Savetimetable.unscoped.all.count
  end
end
