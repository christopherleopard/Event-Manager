class BoardBook < ApplicationRecord
  has_one_attached :pdf

  SCHOOL_YEARS = [
    "WLPS Board Books 2025-2026",
    "WLPS Board Books 2024-2025",
    "WLPS Board Books 2023-2024",
    "WLPS Board Books 2022-2023",
    "WLPS Board Books 2021-2022"
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
