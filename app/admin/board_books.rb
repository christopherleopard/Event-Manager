ActiveAdmin.register BoardBook do
  config.clear_action_items!
  sidebar :filters, only: []

  config.filters = false

  permit_params :school_year, :date, :pdf

  index title: false, download_links: false do
    div class: "custom-message" do
      h2 "WLPS Board Books Management", class: "staff-management-heading"
      para 'To add a new Board Book, click the "Add Board Book" button below. TO update an existing Board Book, locate the Board Book below and click the Edit icon to update the Board Book.', class: "staff-management-description"
      button class: "primary-btn" do
        link_to "Add Board Book", new_admin_board_book_path, class: "text-white"
      end
    end

    div id: "accordion" do
      grouped_minutes = BoardBook.order(school_year: :desc, date: :desc).group_by(&:school_year)

      grouped_minutes.each_with_index do |(school_year, minutes), index|
        collapse_id = "collapse#{index}"

        div class: "card bg-transparent border-0 mb-2" do
          div class: "card-header text-white rounded-0" do
            link_to("#{school_year}", "##{collapse_id}", class: "card-link", data: { toggle: "collapse" })
          end
          div class: [ "collapse", ("show" if index == 0) ].compact.join(" "), id: collapse_id, data: { parent: "#accordion" } do
            minutes.each do |bm|
              div class: "p-3 d-flex align-items-center gap-2 px-4" do
                span do
                  image_tag("pdf.png", alt: "PDF", class: "h-12")
                end
                para bm.date.strftime("%B %d, %Y"), class: "mb-0 fw-semibold"
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
