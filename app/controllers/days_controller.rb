class DaysController < ApplicationController
  def mark_completed
    @day = Day.find(params[:id])
    @day.toggle_completed
    render :nothing => true 
  end
end
