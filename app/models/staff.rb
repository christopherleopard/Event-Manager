class Staff < ApplicationRecord
  DEPARTMENTS = [ "Administration", "Early Childhood Center", "Go Like the Wind Montessori", "Elementary School", "Middle & High School", "Counseling", "Transportation" ]

  validates :name, :title, :department, :phone, :email, presence: true
  validates :department, inclusion: { in: DEPARTMENTS }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def self.ransackable_attributes(auth_object = nil)
    %w[id name title department phone email]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
