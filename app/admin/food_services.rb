ActiveAdmin.register_page "Food Services" do
  menu label: "Food Services", priority: 3

  content title: false do
    div class: "custom-message" do
      h2 "WLPS School Lunch Menus", class: "staff-management-heading"
      para "Use the Upload PDF buttons below to replace the current menu with a new menu. Menus will be displayed on the Food Service Menus webpage.", class: "staff-management-description"
    end

    div class: "lunch_manage d-flex justify-content-center gap-4 align-items-end mt-4" do
      FoodService::SCHOOLS.each do |school|
        record = FoodService.find_or_create_by!(school: school)

        div class: "school_lunch flex-1" do
          para "#{record.school}", class: "text-center ff-bb mb-2"
          div class: "lunch_menu" do
            div style: "width: 100%; height: 260px; border: 2px solid #ccc; display: flex; align-items: center; justify-content: center; overflow: hidden;" do
              if record.pdf.attached?
                link_to "#{record.pdf.filename}", rails_blob_path(record.pdf, disposition: "attachment"), class: "text-center"
              else
                span "No Menu", class: "text-muted"
              end
            end
            
            div class: "mt-3" do
              button class: "primary-bg p-3 w-100 border-0 rounded-0 pdf_uploader" do
                "Upload PDF"
              end
            end

            div class: "pdf_selector" do
              form_with url: admin_food_services_upload_pdf_path(id: record.id), method: :post, html: { multipart: true }, local: true do |f|
                f.file_field :pdf, direct_upload: true, class: "form-control pdf_control hidden-file-input", onchange: "this.form.submit();"
              end
            end
          end
        end
      end
    end
  end

  page_action :upload_pdf, method: :post do
    record = FoodService.find(params[:id])
    record.pdf.purge if record.pdf.attached?
    record.pdf.attach(params[:pdf]) if params[:pdf].present?
    redirect_to admin_food_services_path, notice: "Updated PDF for #{record.school}"
  end
end
