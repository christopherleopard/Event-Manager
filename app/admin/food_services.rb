ActiveAdmin.register_page "Food Services" do
  menu label: "Food Services", priority: 3

  content title: false do
    div class: "lunch_manage d-flex justify-content-center gap-4 align-items-end" do
      FoodService::SCHOOLS.each do |school|
        record = FoodService.find_or_create_by!(school: school)

        div class: "school_lunch w-100" do
          para "#{record.school}", class: "text-center font-weight-bold mb-2"
          div class: "mb-4" do
            div style: "width: 100%; height: 260px; border: 2px solid #ccc; display: flex; align-items: center; justify-content: center; overflow: hidden;" do
              if record.pdf.attached?
                link_to "#{record.pdf.filename}", rails_blob_path(record.pdf, disposition: "attachment")
              else
                span "No PDF", class: "text-muted"
              end
            end

            div class: "mt-2" do
              form_with url: admin_food_services_upload_pdf_path(id: record.id), method: :post, html: { multipart: true }, local: true do |f|
                f.file_field :pdf, direct_upload: true, class: "form-control", onchange: "this.form.submit();"
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
