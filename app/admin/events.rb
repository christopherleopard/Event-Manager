ActiveAdmin.register Event do
  config.clear_action_items!
  sidebar :filters, only: []

  config.filters = false

  permit_params :name, :description, :starts_at_date, :starts_at_time

  index title: false do
    div class: "custom-message" do
      h2 "WLPS Events Management", class: "staff-management-heading"
      para "Click the button below to create a new event. Use the table below to view, edit, and delete current events. All events will automatically be removed after their event date has passed", class: "staff-management-description"
      button class: "primary-btn" do
        link_to "Create Event", new_admin_event_path, class: "text-white"
      end
    end

    div do
      table class: "min-w-full border-collapse bg-white shadow rounded-lg" do
        thead class: "bg-gray-100 text-left" do
          tr do
            th class: "p-3 text-white" do "Event Date" end
            th class: "p-3 text-white" do "Event Name" end
            th class: "p-3 text-white" do "" end
          end
        end

        tbody class: "divide-y divide-gray-200" do
          Event.all.each do |event|
            tr class: "hover:bg-gray-50" do
              td class: "p-3" do event.starts_at_date.strftime("%m/%d/%Y") if event.starts_at_date.present? end
              td class: "p-3" do event.name end
              td class: "p-3 d-flex gap-3 justify-content-end" do
                span { link_to image_tag("edit.png", alt: "Edit"), edit_admin_event_path(event), class: "text-blue-600" }
                span { link_to image_tag("delete.png", alt: "Delete"), admin_event_path(event), method: :delete, data: { confirm: "Are you sure?" }, class: "text-red-600" }
              end
            end
          end
        end
      end
    end
  end
  form do |f|
    div class: "mb-3" do
      h2 "Create a New Event", class: "mb-1"
      para "Fill out the fields below to create your new event. Once created, the event will appear in the Events section at the top of the homepage. Once the event date has passed, the event will automatically be deleted", class: "mb-30"
    end

    f.inputs do
      f.input :starts_at_date, as: :datepicker, label: "Event Date", input_html: { class: "form-control custom-date" }
      f.input :name, label: "Event Name"
      f.input :starts_at_time, as: :time_picker, label: "Event Time"
      f.input :description, label: "Event Details"
    end
    f.actions
  end
end
