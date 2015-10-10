class Day < ActiveRecord::Base
  belongs_to :weeks

  def toggle_completed
    self.update_attributes!({:completed => !Day.first.completed})
  end
end
