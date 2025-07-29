class EmergencyAlert < ApplicationRecord
  validates :name, presence: true
  validates :message, presence: true

  before_save :disable_other_alerts, if: :should_disable_others?

  scope :active, -> { where(enabled: true) }

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at enabled id message name updated_at]
  end

  private

  def should_disable_others?
    enabled_changed? && enabled?
  end

  def disable_other_alerts
    EmergencyAlert.where.not(id: id).update_all(enabled: false)
  end
end
