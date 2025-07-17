ActiveAdmin.register Staff do
  permit_params :name, :role, :resume
  index do
    selectable_column
    id_column
    column :name
    column :role
    column "Resume" do |staff|
      if staff.resume.attached?
        link_to staff.resume.filename.to_s, rails_blob_url(staff.resume, disposition: "attachment")
      end
    end
    actions
  end
  form do |f|
    f.inputs multipart: true do
      f.input :name
      f.input :role
      f.input :resume, as: :file, hint: f.object.resume.attached? ? f.object.resume.filename.to_s : content_tag(:span, "Upload PDF")
    end
    f.actions
  end
end
