class HomeController < ApplicationController
  def index
    @events = Event.order(starts_at_date: :desc).limit(3)
    @emergency_alerts = EmergencyAlert.all
    @home_pdfs = PdfDocument.where(page_title: "Home").includes(:pdf_attachment, :pdf_blob)
  end
end
