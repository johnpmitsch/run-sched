class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.string :activity
      t.date :date
      t.boolean :completed
      t.references :week, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
