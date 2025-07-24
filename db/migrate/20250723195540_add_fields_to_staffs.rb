class AddFieldsToStaffs < ActiveRecord::Migration[8.0]
  def change
    add_column :staffs, :title, :string
    add_column :staffs, :department, :string
    add_column :staffs, :phone, :string
    add_column :staffs, :email, :string
  end
end
