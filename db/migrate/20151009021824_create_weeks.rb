class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.references :schedule, index: true, foreign_key: true
      t.integer :number

      t.timestamps null: false
    end
  end
end
