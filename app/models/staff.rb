class Staff < ApplicationRecord
  has_one_attached :resume
  validates :name, :role, :resume, presence: true
  validates :resume, content_type: ['application/pdf']
end