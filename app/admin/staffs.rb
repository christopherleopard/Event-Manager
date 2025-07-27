ActiveAdmin.register Staff do
  config.clear_action_items!
  sidebar :filters, only: []

  config.filters = false

  permit_params :name, :title, :department, :phone, :email

  index title: false do
    selected = params[:department]
    departments = Staff::DEPARTMENTS

    div class: "custom-message" do
      h2 "WPLS Staff Management", class: "staff-management-heading"
      para 'You can view staff by department below by selecting a department from the dropdown menu. The order of staff members can be changed using the provided drag-and-drop sort function. You can edit and delete staff members from this page, and you can create new staff members by clicking the "Create Staff" button below.', class: "staff-management-description"
      button class: "primary-btn" do
        link_to "Create Staff", new_admin_staff_path, class: "text-white"
      end

      div class: "mb-3" do
        form method: :get, action: admin_staffs_path do
          select_tag :department, options_for_select([ [ "Select a Department", "" ] ] + departments.map { |d| [ d, d ] }, selected), class: "form-select d-inline-block w-auto me-2", onchange: "this.form.submit();"
        end
      end
    end

    staffs = selected.present? ? Staff.where(department: selected) : []

    if selected.present?
      h2 class: "text-center" do
        "#{selected}"
      end
    end

    div do
      table do
        thead do
          tr do
            th do "" end
            th class: "p-3 text-white" do "Name" end
            th class: "p-3 text-white" do "Title" end
            th class: "p-3 text-white" do "Department" end
            th class: "p-3 text-white" do "Phone" end
            th class: "p-3 text-white" do "Email" end
            th class: "p-3 text-white" do "" end
          end
        end

        tbody do
          staffs.each do |s|
            tr do
              td class: "p-3" do
                span do
                  image_tag("move.png", alt: "Move")
                end
              end
              td class: "p-3" do s.name end
              td class: "p-3" do s.title end
              td class: "p-3" do s.department end
              td class: "p-3" do s.phone end
              td class: "p-3" do s.email end
              td class: "p-3 d-flex gap-3 justify-content-end" do
                span { link_to image_tag("edit.png", alt: "Edit"), edit_admin_staff_path(s) }
                span { link_to image_tag("delete.png", alt: "Delete"), admin_staff_path(s), method: :delete, data: { confirm: "Are you sure?" } }
              end
            end
          end
        end
      end
    end
  end

  form do |f|
    div class: "mb-3" do
      h2 "Create New Staff Member", class: "mb-1"
      para "Fill out the form below to create a new staff member to appear on the website.", class: "mb-30"
    end

    f.inputs do
      f.input :name
      f.input :title
      f.input :department, as: :select, collection: Staff::DEPARTMENTS, include_blank: false
      f.input :phone
      f.input :email
    end
    f.actions
  end
end
