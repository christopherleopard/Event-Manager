class Staff < ApplicationRecord
  validates :name, :title, :department, :phone, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def self.ransackable_attributes(auth_object = nil)
    %w[id name title department phone email]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
