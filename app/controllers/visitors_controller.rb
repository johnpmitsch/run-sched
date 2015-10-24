class VisitorsController < ApplicationController
  def index
    if user_signed_in?
      puts 'hi'
      redirect_to schedules_path
    end
  end
end
