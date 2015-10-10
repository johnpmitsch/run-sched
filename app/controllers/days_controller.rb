class DaysController < ApplicationController
  def toggle_completed
    self.update_attributes!({:completed => !Day.first.completed})
  end
end
