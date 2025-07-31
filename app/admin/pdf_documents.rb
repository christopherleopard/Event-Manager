# app/admin/pdf_documents.rb
ActiveAdmin.register PdfDocument do
  config.clear_action_items!
  sidebar :filters, only: []

  config.filters = false
  
  permit_params :page_title, :title, :pdf

  form do |f|
    f.semantic_errors

    f.inputs "PDF Details" do
      # Show dropdown only on create
      if f.object.new_record?
        f.input :page_title, as: :select, collection: PdfDocument::PAGE_TITLES, include_blank: false
      else
        f.input :page_title, input_html: { disabled: true }
      end

      f.input :title

      if f.object.pdf.attached?
        f.input :pdf, as: :file, hint: link_to(f.object.pdf.filename.to_s, rails_blob_path(f.object.pdf, disposition: "attachment", only_path: true))
      else
        f.input :pdf, as: :file
      end
    end

    f.actions
  end

  show do
    attributes_table do
      row :page_title
      row :title
      row :file do |pdf|
        if pdf.pdf.attached?
          link_to pdf.pdf.filename.to_s, rails_blob_path(pdf.pdf, disposition: "attachment", only_path: true)
        else
          "No file uploaded"
        end
      end
    end
  end

  controller do
    def update
      # Prevent page_title from being changed in update
      params[:pdf_document].delete(:page_title)
      super
    end
  end
end
