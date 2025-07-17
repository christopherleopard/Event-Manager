class Event < ApplicationRecord
  validates :name, :starts_at, :ends_at, presence: true
  validate :ends_after_start
  
  def self.ransackable_attributes(auth_object = nil)
    %w[id name description starts_at ends_at created_at updated_at]
  end

  def ends_after_start
    return unless ends_at && starts_at
    errors.add(:ends_at, "must be after start time") if ends_at < starts_at
  end
end