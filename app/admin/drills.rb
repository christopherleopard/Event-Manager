ActiveAdmin.register Drill do
  config.clear_action_items!
  sidebar :filters, only: []

  config.filters = false

  permit_params :school, :drill_type, :date, :time, :pdf

  index title: "Drills Management" do
    div class: "custom-message" do
      h2 "WLPS Board Books Management", class: "staff-management-heading"
      para "You can view board minutes by school year below. The order of board minutes can be changed using the provided drag-and-drop sort function. You can edit and delete board minutes from this page, and you can create new board minutes by clicking the 'Create Board Minute' button below.", class: "staff-management-description"
      button class: "primary-btn" do
        link_to "Create New Drill", new_admin_drill_path, class: "text-white"
      end
    end

    div id: "accordion" do
      [ "ECC", "WLES", "GLTW", "WLMS/HS" ].each_with_index do |(school_name), index|
        collapse_id = "collapse#{index}"

        div class: "card" do
          div class: "card-header" do
            link_to("#{school_name} Drills", "##{collapse_id}", class: "card-link text-white", data: { toggle: "collapse" })
          end

          div class: [ "collapse", ("show" if index == 0) ].compact.join(" "), id: collapse_id, data: { parent: "#accordion" } do
            drills = Drill.where(school: school_name).order(date: :desc, time: :desc)

              if drills.any?
                div do
                  div class: "d-flex" do
                    div class: "p-3 text-white" do "Drill Type" end
                    div class: "p-3 text-white" do "Date" end
                    div class: "p-3 text-white" do "Time" end
                    div class: "p-3 text-white" do "" end
                  end

                  div do
                    drills.each do |drill|
                      div class: "d-flex" do
                        div class: "p-3" do drill.drill_type end
                        div class: "p-3" do drill.date end
                        div class: "p-3" do drill.time end

                        div class: "p-3" do
                          span link_to("Edit", edit_admin_drill_path(drill))
                          span link_to("Delete", admin_drill_path(drill), method: :delete, data: { confirm: "Are you sure?" })
                        end
                      end
                    end
                  end
                end
              else
                div "No drills available for this school."
              end
            end
        end
      end
    end
  end

  form do |f|
    f.inputs "Drill Details" do
      f.input :school, as: :select, collection: [ "ECC", "WLES", "GLTW", "WLMS/HS" ], prompt: "Select School"
      f.input :drill_type, as: :select, collection: [ "Fire", "Storm", "Lockdown" ], prompt: "Select Drill Type"
      f.input :date, as: :datepicker
      f.input :time, as: :time_picker
      f.input :pdf, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :school
      row :drill_type
      row :date
      row :time
      row :pdf do |drill|
        if drill.pdf.attached?
          link_to "View PDF", url_for(drill.pdf), target: "_blank"
        else
          status_tag "No PDF"
        end
      end
    end
  end
end
