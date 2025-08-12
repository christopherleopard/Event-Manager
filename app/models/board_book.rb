class BoardBook < ApplicationRecord
  has_one_attached :pdf

  SCHOOL_YEARS = [
    "WLPS Board Books 2024-2025",
    "WLPS Board Books 2023-2024",
    "WLPS Board Books 2022-2023",
    "WLPS Board Books 2021-2022",
    "WLPS Board Books 2020-2021",
    "WLPS Board Books 2019-2020",
    "WLPS Board Books 2018-2019",
    "WLPS Board Books 2017-2018",
    "WLPS Board Books 2016-2017",
    "WLPS Board Books 2015-2016",
    "WLPS Board Books 2014-2015",
    "WLPS Board Books 2013-2014",
    "WLPS Board Books 2012-2013",
    "WLPS Board Books 2011-2012"
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
