class Drill < ApplicationRecord
  has_one_attached :pdf
  SCHOOLS = [
    "ECC",
    "WLES",
    "GLTW",
    "WLMS/HS"
  ]
  Drill_Types = [
    "Fire",
    "Storm",
    "Lockdown"
  ]

  validates :date, :time, presence: true
  validates :school, inclusion: { in: SCHOOLS }
  validates :drill_type, inclusion: { in: Drill_Types }

  def self.ransackable_attributes(auth_object = nil)
    [ "drill_type", "school", "date", "time" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "pdf_attachment", "pdf_blob" ]
  end
end
