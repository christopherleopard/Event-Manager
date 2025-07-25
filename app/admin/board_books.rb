ActiveAdmin.register BoardBook do
  config.clear_action_items!
  sidebar :filters, only: []

  config.filters = false

  permit_params :school_year, :date, :pdf

  index title: false, download_links: false do
    div class: "custom-message" do
      h2 "WLPS Board Books Management", class: "staff-management-heading"
      para "You can view board minutes by school year below. The order of board minutes can be changed using the provided drag-and-drop sort function. You can edit and delete board minutes from this page, and you can create new board minutes by clicking the 'Create Board Minute' button below.", class: "staff-management-description"
      button class: "primary-btn" do
        link_to "Create Board Minute", new_admin_board_minute_path, class: "text-white"
      end
    end

    div id: "accordion" do
      grouped_minutes = BoardBook.order(school_year: :desc, date: :desc).group_by(&:school_year)

      grouped_minutes.each_with_index do |(school_year, minutes), index|
        collapse_id = "collapse#{index}"

        div class: "card" do
          div class: "card-header" do
            link_to("#{school_year}", "##{collapse_id}", class: "card-link", data: { toggle: "collapse" })
          end
          div class: [ "collapse", ("show" if index == 0) ].compact.join(" "), id: collapse_id, data: { parent: "#accordion" } do
            minutes.each do |bm|
              div class: "p-2" do
                para bm.date.strftime("%B %d, %Y"), class: "mb-1 font-semibold"

                if bm.pdf.attached?
                  para link_to("Download PDF", rails_blob_path(bm.pdf, disposition: "attachment", only_path: true), class: "text-blue-600")
                else
                  para status_tag("No file", :warning)
                end

                div class: "space-x-2 mt-1" do
                  span { link_to "Edit", edit_admin_board_minute_path(bm), class: "text-sm text-blue-500" }
                  span { link_to "Delete", admin_board_minute_path(bm), method: :delete, data: { confirm: "Are you sure?" }, class: "text-sm text-red-500" }
                end
              end
            end
          end
        end
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :school_year, as: :select, collection: BoardBook::SCHOOL_YEARS, include_blank: false
      f.input :date, as: :datepicker
      f.input :pdf, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :school_year
      row :date
      row :pdf do |bm|
        if bm.pdf.attached?
          link_to "View PDF", rails_blob_path(bm.pdf, disposition: "attachment", only_path: true)
        else
          status_tag "No File"
        end
      end
    end
  end
end
