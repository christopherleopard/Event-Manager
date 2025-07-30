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
            tr do
              td class: "p-3 min-8" do emergency_alert.name end
              td class: "p-3" do emergency_alert.message end
              td class: "p-3" do 
                emergency_alert.enabled
                div class: "form-check form-switch" do
                  input type: "checkbox", class: "form-check-input alert-toggle", id: "alert_toggle_#{emergency_alert.id}", data: { id: emergency_alert.id }, checked: emergency_alert.enabled
                end
              end
              td class: "p-3 d-flex gap-2 justify-content-end min-5" do
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
    div class: "mb-3" do
      h2 "Create New Emergency Alert", class: "mb-1"
      para do
        span "Enter in the necessary text below and save your alert. Once save, you will be returned to the main Emergency Alert Management page and your alert will be "
        strong "active. "
        span "From there, you can "
        strong "activate the alert "
        span "to turn it on. It will enable a pop-up on the website for users immediately upon their arrival to the website. "
        span "You can also deactivate the alert to turn it off and disable the pop-up from the website once the emergency is over."
      end
    end

    f.inputs do
      div class: "d-flex" do
        div class: "flex-1" do
          f.input :name, input_html: { class: "p-2 mt-2 w-100 border border-1 border-black" }
        end
      end
      div class: "d-flex mt-2" do
        div class: "flex-1" do
          f.input :message, input_html: { rows: 5, class: "p-2 mt-2 w-100 border border-1 border-black" }
        end
      end
    end
    f.actions do
      f.action :submit, label: "Save", button_html: { class: "primary-btn" }
    end
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
