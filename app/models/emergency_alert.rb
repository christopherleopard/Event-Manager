class EmergencyAlert < ApplicationRecord
  validates :name, presence: true
  validates :message, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "enabled", "id", "message", "name", "updated_at" ]
  end

  def self.active
    where(enabled: true)
  end
end
