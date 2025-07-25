class CreateDrills < ActiveRecord::Migration[8.0]
  def change
    create_table :drills do |t|
      t.string :school
      t.string :drill_type
      t.date :date
      t.time :time

      t.timestamps
    end
  end
end
