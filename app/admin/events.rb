ActiveAdmin.register Event do
  permit_params :name, :description, :starts_at, :ends_at
  index do
    selectable_column
    id_column
    column :name
    column :starts_at
    column :ends_at
    actions
  end
  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :starts_at, as: :datetime_picker
      f.input :ends_at, as: :datetime_picker
    end
    f.actions
  end
end
