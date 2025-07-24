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
      table class: "min-w-full border-collapse bg-white shadow rounded-lg" do
        thead class: "bg-gray-100 text-left" do
          tr do
            th class: "p-3 text-white" do "Name" end
            th class: "p-3 text-white" do "Title" end
            th class: "p-3 text-white" do "Department" end
            th class: "p-3 text-white" do "Phone" end
            th class: "p-3 text-white" do "Email" end
            th class: "p-3 text-white" do "" end
          end
        end

        tbody class: "divide-y divide-gray-200" do
          staffs.each do |s|
            tr class: "hover:bg-gray-50" do
              td class: "p-3 text-primary" do link_to s.name, admin_staff_path(s) end
              td class: "p-3" do s.title end
              td class: "p-3" do s.department end
              td class: "p-3" do s.phone end
              td class: "p-3" do mail_to s.email end
              td class: "p-3 space-x-2" do
                span { link_to "Edit", edit_admin_staff_path(s), class: "text-blue-600" }
                span { link_to "Delete", admin_staff_path(s), method: :delete, data: { confirm: "Are you sure?" }, class: "text-red-600" }
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
