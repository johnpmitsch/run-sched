class DaysController < ApplicationController
  def mark_completed
    @day = Day.find(params[:id])
    @day.toggle_completed
    respond_to do |format|
      format.js
    end
  end
end
