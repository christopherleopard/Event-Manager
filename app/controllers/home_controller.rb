class HomeController < ApplicationController
  def index
    @events = Event.all
    @home_pdfs = PdfDocument.where(page_title: "Home").includes(:pdf_attachment, :pdf_blob)
  end
end
