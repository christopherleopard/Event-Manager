ActiveAdmin.register EmergencyAlert do
  config.clear_action_items!
  sidebar :filters, only: []

  config.filters = false

  permit_params :name, :message, :enabled

  index title: false do
    div class: "custom-message" do
      h2 "WLPS Emergency Alert Management", class: "staff-management-heading"
      para 'Click the "Create New Alert" button to create a new emergency alert message. Once saved, you can activate and deactivate the message using the toggle in the "Active" column to enable/disable the emergency alert pop-up from the website.'
      button class: "primary-btn" do
        link_to "Create a New Alert", new_admin_emergency_alert_path, class: "text-white"
      end
    end

    div do
      table class: "min-w-full border-collapse bg-white shadow rounded-lg" do
        thead class: "bg-gray-100 text-left" do
          tr do
            th class: "p-3 text-white" do "Alert Name" end
            th class: "p-3 text-white" do "Alert Message" end
            th class: "p-3 text-white" do "Active" end
            th class: "p-3 text-white" do "" end
          end
        end

        tbody class: "divide-y divide-gray-200" do
          EmergencyAlert.all.each do |emergency_alert|
            tr class: "hover:bg-gray-50" do
              td class: "p-3" do emergency_alert.name end
              td class: "p-3 text-primary" do emergency_alert.message end
              td class: "p-3" do 
                emergency_alert.enabled
                div class: "form-check form-switch" do
                  input type: "checkbox", class: "form-check-input", id: "flexSwitchCheckDefault", checked: emergency_alert.enabled
                end
              end
              td class: "p-3 d-flex gap-3 justify-content-end" do
                span { link_to image_tag("edit.png", alt: "Edit"), edit_admin_emergency_alert_path(emergency_alert), class: "text-blue-600" }
                span { link_to image_tag("delete.png", alt: "Delete"), admin_emergency_alert_path(emergency_alert), method: :delete, data: { confirm: "Are you sure?" }, class: "text-red-600" }
              end
            end
          end
        end
      end
    end
  end

  form do |f|
    f.inputs "Alert Details" do
      f.input :name
      f.input :message
      f.input :enabled, as: :boolean
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :message
      row :enabled
      row :created_at
      row :updated_at
    end
  end
end
