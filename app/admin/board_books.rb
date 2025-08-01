ActiveAdmin.register BoardBook do
  config.clear_action_items!
  sidebar :filters, only: []

  config.filters = false

  permit_params :school_year, :date, :pdf

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
          redirect_to collection_path, notice: "Board Book updated" and return
        end
        failure.html { render :edit, status: :unprocessable_entity and return }
      end
    end
  end

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
          div class: "card-header text-white rounded-0 ff-b fw-semibold d-flex justify-content-between" do
            div do
              link_to("#{school_year}", "##{collapse_id}", class: "card-link", data: { toggle: "collapse" })
            end
            div class: "status_icons" do
              span class: ["status_icon", (index == 0 ? "hide" : "show")].compact.join(" ") do "+" end
              span class: ["status_icon", (index == 0 ? "show" : "hide")].compact.join(" ") do "-" end
            end
          end
          div class: [ "mt-3 mb-2 collapse", ("show" if index == 0) ].compact.join(" "), id: collapse_id, data: { parent: "#accordion" } do
            minutes.each do |bm|
              div class: "p-3 d-flex align-items-center gap-2 px-4" do
                span do
                  image_tag("pdf.png", alt: "PDF", class: "h-12")
                end
                para bm.date.strftime("%B %d, %Y"), class: "mb-0 fw-semibold fs-20"
              end
            end
          end
        end
      end
    end
  end

  form do |f|
    div class: "mb-3" do
      h2 "Create Board Book", class: "mb-1"
      para 'Enter in the date for the Board Book below and upload your PDF. Click "Save" to save your update and add it to the Board Books webpage.', class: "mb-30"
    end
    f.inputs do
      div class: "d-flex gap-3" do
        div class: "flex-1" do
          f.input :school_year, as: :select, collection: BoardBook::SCHOOL_YEARS, include_blank: false, label: "School Year", prompt: "Select School Year", input_html: { class: "p-2 mt-2 w-100 border border-1 border-black" }
        end
        div class: "flex-1" do
          f.input :date, as: :datepicker, input_html: { class: "p-2 mt-2 w-100 border border-1 border-black" }
        end
      end
      div class: "mt-3" do
        f.input :pdf, label: "Upload PDF", as: :file, input_html: { class: "mt-2" }
      end
    end
    f.actions do
      f.action :submit, label: "Save", button_html: { class: "primary-btn" }
    end
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
