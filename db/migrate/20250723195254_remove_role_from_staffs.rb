class RemoveRoleFromStaffs < ActiveRecord::Migration[8.0]
  def change
    remove_column :staffs, :role, :string
  end
end
