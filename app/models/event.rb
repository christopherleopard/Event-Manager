class Event < ApplicationRecord
  validates :name, :starts_at_date, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[id name description starts_at_date created_at updated_at]
  end

  def ends_after_start
    nil unless starts_at_date
  end
end
