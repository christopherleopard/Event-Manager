ActiveAdmin.register AdminUser do
  config.clear_action_items!
  sidebar :filters, only: []

  config.filters = false

  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
