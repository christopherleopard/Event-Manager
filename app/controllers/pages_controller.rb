class PagesController < ApplicationController
  def facilities
    @facility_pdfs = PdfDocument.where(page_title: "Facilities").includes(:pdf_attachment, :pdf_blob)
  end

  def special_education
    @special_education_pdfs = PdfDocument.where(page_title: "Special Education").includes(:pdf_attachment, :pdf_blob)
  end

  def food_service
    @food_service_pdfs = PdfDocument.where(page_title: "Food Service").includes(:pdf_attachment, :pdf_blob)
  end

  def menus
    @menu_pdfs = PdfDocument.where(page_title: "Menus").includes(:pdf_attachment, :pdf_blob)
  end

  def family_resources
    @family_resources_pdfs = PdfDocument.where(page_title: "Family Resources").includes(:pdf_attachment, :pdf_blob)
  end

  def kids_club
    @kids_club_pdfs = PdfDocument.where(page_title: "Kids Club").includes(:pdf_attachment, :pdf_blob)
  end

  def athletics
    @athletics_pdfs = PdfDocument.where(page_title: "Athletics").includes(:pdf_attachment, :pdf_blob)
  end
end
