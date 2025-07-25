class BoardMinute < ApplicationRecord
  has_one_attached :pdf

  SCHOOL_YEARS = [
    "WLPS Board of Education Meeting Minutes 2021-2022", "WLPS Board of Education Meeting Minutes 2022-2023", "WLPS Board of Education Meeting Minutes 2023-2024", "WLPS Board of Education Meeting Minutes 2024-2025", "WLPS Board of Education Meeting Minutes 2025-2026"
  ]

  validates :school_year, inclusion: { in: SCHOOL_YEARS }
  validates :date, :pdf, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ "school_year", "date", "created_at", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "pdf_attachment", "pdf_blob" ]
  end
end
