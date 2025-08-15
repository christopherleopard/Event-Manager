# app/models/fund_form.rb
class FundForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations::Callbacks

  attribute :first_name, :string
  attribute :last_name,  :string
  attribute :email,      :string
  attribute :phone,      :string
  attribute :message,    :string
  attribute :trap,       :string # honeypot

  before_validation :normalize_fields

  validates :first_name, :last_name, presence: true, length: { maximum: 80 }
  validates :email, presence: true, format: URI::MailTo::EMAIL_REGEXP
  validates :message, presence: true, length: { maximum: 2000 }
  validate  :honeypot_empty
  validate  :phone_format, if: -> { phone.present? }

  def full_name
    "#{first_name} #{last_name}".strip
  end

  private

  def normalize_fields
    self.email = email.to_s.strip
    self.phone = phone.to_s.strip
  end

  def honeypot_empty
    errors.add(:base, "Spam detected") if trap.present?
  end

  def phone_format
    digits = phone.gsub(/\D/, "")
    errors.add(:phone, "looks invalid") unless digits.length.between?(7, 20)
  end
end
