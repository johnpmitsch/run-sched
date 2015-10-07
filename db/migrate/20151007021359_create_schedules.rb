class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.date :race_day
      t.string :monday
      t.string :tuesday
      t.string :wednesday
      t.string :thursday
      t.string :friday
      t.string :saturday
      t.string :sunday
      t.string :race_type
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
