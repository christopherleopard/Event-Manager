class CreateFoodServices < ActiveRecord::Migration[8.0]
  def change
    create_table :food_services do |t|
      t.string :school

      t.timestamps
    end
  end
end
