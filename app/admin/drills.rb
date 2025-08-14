ActiveAdmin.register Drill do
  config.clear_action_items!
  sidebar :filters, only: []

  config.filters = false

  permit_params :school, :drill_type, :date, :time, :pdf

  controller do
    def create
      super do |success, failure|
        success.html do
          redirect_to collection_path, notice: "Board Book created" and return
        end
        failure.html { render :new, status: :unprocessable_entity and return }
      end
    end
    
    def update
      super do |success, failure|
        success.html do
          redirect_to collection_path, notice: "Drill updated" and return
        end
        failure.html { render :edit, status: :unprocessable_entity and return }
      end
    end
  end

  index title: "Drills Management" do
    div class: "custom-message" do
      h2 "WLPS Safety Drills Management", class: "staff-management-heading"
      para "You can use the button below to create a new safety drill. The tables for each school allow you to edit and delete your drills, as needed.", class: "staff-management-description"
      button class: "primary-btn" do
        link_to "Create New Drill", new_admin_drill_path, class: "text-white"
      end
    end

    div id: "accordion" do
      [ "ECC", "WLES", "GLTW", "WLMS/HS" ].each_with_index do |(school_name), index|
        collapse_id = "collapse#{index}"

        div class: "card bg-transparent border-0 mb-2" do
          div class: "card-header text-white rounded-0 ff-b fw-semibold d-flex justify-content-between" do
            div do
              link_to("#{school_name} Drills", "##{collapse_id}", class: "card-link", data: { toggle: "collapse" })
            end
            div class: "status_icons" do
              span class: ["status_icon", (index == 0 ? "hide" : "show")].compact.join(" ") do "+" end
              span class: ["status_icon", (index == 0 ? "show" : "hide")].compact.join(" ") do "-" end
            end
          end

          div class: [ "collapse mt-3 mb-2", ("show" if index == 0) ].compact.join(" "), id: collapse_id, data: { parent: "#accordion" } do
            drills = Drill.where(school: school_name).order(date: :desc, time: :desc)

              if drills.any?
                div do
                  div class: "d-flex", style: "background: #D32128;" do
                    para class: "p-3 text-white mb-0 w-4p" do "Drill Type" end
                    para class: "p-3 text-white mb-0 w-2p" do "Date" end
                    para class: "p-3 text-white mb-0 w-3p" do "Time" end
                    para class: "p-3 text-white mb-0 w-1p" do "" end
                  end

                  div do
                    drills.each_with_index do |(drill), index2|
                      div class: "d-flex drill_#{index2}" do
                        div class: "p-3 w-4p" do drill.drill_type end
                        div class: "p-3 w-2p" do drill.date.strftime("%m/%d/%Y") end
                        div class: "p-3 w-3p" do drill.time.strftime("%-I:%M %p") end

                        div class: "p-3 w-1p d-flex gap-3 justify-content-end" do
                          span link_to(image_tag("edit.png", alt: "Edit"), edit_admin_drill_path(drill))
                          span link_to(image_tag("delete.png", alt: "Delete"), admin_drill_path(drill), method: :delete, data: { confirm: "Are you sure?" })
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
    div class: "mb-3" do
      h2 "Create New Drill", class: "mb-1"
      end
    f.inputs do
      div class: "d-flex gap-3" do
        div class: "flex-1" do
          f.input :school, as: :select, collection: [ "ECC", "WLES", "GLTW", "WLMS/HS" ], prompt: "Select School", input_html: { class: "p-2 mt-2 w-100 border border-1 border-black" }
        end
        div class: "flex-1" do
          f.input :drill_type, as: :select, label:"Drill Type", collection: [ "Fire", "Storm", "Lockdown" ], prompt: "Select Drill Type", input_html: { class: "p-2 mt-2 w-100 border border-1 border-black" }
        end
      end
      div class: "d-flex gap-3 mt-2" do
        div class: "flex-1" do
          f.input :date, as: :datepicker, input_html: { class: "p-2 mt-2 w-100 border border-1 border-black" }
        end
        div class: "flex-1" do
          f.input :time, as: :time_picker, input_html: { class: "p-2 mt-2 w-100 border border-1 border-black" }
        end
      end
      div class: "d-flex gap-3 mt-2" do
        div class: "flex-1" do
          f.input :pdf, as: :file, label: "Upload PDF"
        end
      end
    end
    f.actions do
      f.action :submit, label: "Save", button_html: { class: "primary-btn" }
    end
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
