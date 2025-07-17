class Staff < ApplicationRecord
  has_one_attached :resume

  validates :name, :role, :resume, presence: true
  validates :resume, content_type: ['application/pdf']

  def self.ransackable_attributes(auth_object = nil)
    %w[id name role created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    ["resume_attachment", "resume_blob"]
  end
end
