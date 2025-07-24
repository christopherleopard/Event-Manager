class SplitStartsAtInEvents < ActiveRecord::Migration[8.0]
  def change
    remove_column :events, :starts_at, :datetime

    add_column :events, :starts_at_date, :date
    add_column :events, :starts_at_time, :time
  end
end
