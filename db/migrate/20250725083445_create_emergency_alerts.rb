class CreateEmergencyAlerts < ActiveRecord::Migration[8.0]
  def change
    create_table :emergency_alerts do |t|
      t.string :name
      t.text :message
      t.boolean :enabled

      t.timestamps
    end
  end
end
