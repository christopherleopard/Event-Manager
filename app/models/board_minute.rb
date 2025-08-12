class BoardMinute < ApplicationRecord
  has_one_attached :pdf

  SCHOOL_YEARS = [
    "WLPS Board of Education Meeting Minutes 2024-2025",
    "WLPS Board of Education Meeting Minutes 2023-2024",
    "WLPS Board of Education Meeting Minutes 2022-2023",
    "WLPS Board of Education Meeting Minutes 2021-2022",
    "WLPS Board of Education Meeting Minutes 2020-2021",
    "WLPS Board of Education Meeting Minutes 2019-2020",
    "WLPS Board of Education Meeting Minutes 2018-2019",
    "WLPS Board of Education Meeting Minutes 2017-2018",
    "WLPS Board of Education Meeting Minutes 2016-2017",
    "WLPS Board of Education Meeting Minutes 2015-2016",
    "WLPS Board of Education Meeting Minutes 2014-2015",
    "WLPS Board of Education Meeting Minutes 2013-2014",
    "WLPS Board of Education Meeting Minutes 2012-2013"
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
