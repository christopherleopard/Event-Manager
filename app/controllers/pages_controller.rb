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

  def district_calendar
    @district_calendar_pdfs = PdfDocument.where(page_title: "District Calendar").includes(:pdf_attachment, :pdf_blob)
  end

  def middle_and_high_school_calendar
    @middle_and_high_school_calendar_pdfs = PdfDocument.where(page_title: "Middle & High School Calendar").includes(:pdf_attachment, :pdf_blob)
  end

  def elementary_school_calendar
    @elementary_school_calendar_pdfs = PdfDocument.where(page_title: "Elementary School Calendar").includes(:pdf_attachment, :pdf_blob)
  end

  def transparency_reporting
    @transparency_reporting_pdfs = PdfDocument.where(page_title: "Transparency Reporting").includes(:pdf_attachment, :pdf_blob)
  end

  def transportation
    @transportation_pdfs = PdfDocument.where(page_title: "Transportation").includes(:pdf_attachment, :pdf_blob)
  end

  def school_of_choice
    @school_of_choice_pdfs = PdfDocument.where(page_title: "School of Choice").includes(:pdf_attachment, :pdf_blob)
    @enrollment = EnrollmentForm.new
  end

  def board_calendars
    @board_calendars_pdfs = PdfDocument.where(page_title: "Board Calendars").includes(:pdf_attachment, :pdf_blob)
  end

  def get_involved
    @get_involved_pdfs = PdfDocument.where(page_title: "Get Involed").includes(:pdf_attachment, :pdf_blob)
  end

  def drills
    @drills = Drill.all
  end

  def bond_updates
    @contact = Contact.new
  end

  def twenty_twentyfour_bond
    @bond = BondForm.new
  end

  def staff
    @staffs = Staff.all
  end

  def board_books
    @board_books = BoardBook.all
  end

  def board_minutes
    @board_minutes = BoardMinute.all
  end
end
