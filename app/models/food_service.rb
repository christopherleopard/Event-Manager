class FoodService < ApplicationRecord
  has_one_attached :pdf

  SCHOOLS = [
    "Early Childhood Center Menu",
    "Elementary Menu",
    "GLTW Menu",
    "Middle & High School Menu"
  ]

  validates :school, inclusion: { in: SCHOOLS }
  validates :school, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    [ "school", "created_at", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "pdf_attachment", "pdf_blob" ]
  end
end
