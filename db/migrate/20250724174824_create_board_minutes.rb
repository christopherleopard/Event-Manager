class CreateBoardMinutes < ActiveRecord::Migration[8.0]
  def change
    create_table :board_minutes do |t|
      t.string :school_year
      t.date :date

      t.timestamps
    end
  end
end
