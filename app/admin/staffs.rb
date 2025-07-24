ActiveAdmin.register Staff do
  permit_params :name, :title, :department, :phone, :email

  index title: "WPLS Staff Management" do
    div class: "custom-message" do
      h2 "WPLS Staff Management"
      para 'You can view staff by department below by selecting a department from the dropdown menu. The order of staff members can be changed using the provided drag-and-drop sort function. You can edit and delete staff members from this page, and you can create new staff members by clicking the "Create Staff" button below.'
    end

    div do
      table class: "min-w-full border-collapse bg-white shadow rounded-lg" do
        thead class: "bg-gray-100 text-left" do
          tr do
            th class: "p-3 font-semibold" do "Name" end
            th class: "p-3 font-semibold" do "Title" end
            th class: "p-3 font-semibold" do "Department" end
            th class: "p-3 font-semibold" do "Phone" end
            th class: "p-3 font-semibold" do "Email" end
            th class: "p-3 font-semibold" do "Actions" end
          end
        end

        tbody class: "divide-y divide-gray-200" do
          Staff.all.each do |s|
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
end
