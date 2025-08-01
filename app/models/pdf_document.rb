class PdfDocument < ApplicationRecord
  has_one_attached :pdf

  validates :page_title, :title, :pdf, presence: true

  PAGE_TITLES = ["Home", "About Us", "Contact", "FAQ", "Terms & Conditions"]

  def self.ransackable_attributes(auth_object = nil)
    %w[id page_title title created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "pdf_attachment", "pdf_blob" ]
  end
end
