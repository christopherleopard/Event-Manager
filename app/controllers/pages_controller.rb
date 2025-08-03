class PagesController < ApplicationController
  def facilities
    @facility_pdfs = PdfDocument.where(page_title: "Facilities").includes(:pdf_attachment, :pdf_blob)
  end

  def spacial_education
    @facility_pdfs = PdfDocument.where(page_title: "Special Education").includes(:pdf_attachment, :pdf_blob)
  end
end
