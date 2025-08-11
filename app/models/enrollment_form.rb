# app/models/enrollment_form.rb
class EnrollmentForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations::Callbacks

  # Attributes
  attribute :first_name, :string
  attribute :last_name,  :string
  attribute :email,      :string
  attribute :phone,      :string
  attribute :address1,   :string
  attribute :address2,   :string
  attribute :city,       :string
  attribute :state,      :string
  attribute :zip,        :string
  attribute :message,    :string
  attribute :trap,       :string # honeypot

  US_STATES = %w[
    AL AK AZ AR CA CO CT DE FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS
    MO MT NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TN TX UT VT VA WA WV
    WI WY DC
  ].freeze

  # Normalization
  before_validation :normalize_fields

  # Validations
  validates :first_name, :last_name, presence: true, length: { maximum: 80 }
  validates :email, presence: true, format: URI::MailTo::EMAIL_REGEXP
  validates :address1, :city, :state, :zip, presence: true
  validates :state, inclusion: { in: US_STATES }
  validates :zip, format: { with: /\A\d{5}(-\d{4})?\z/, message: "must be 12345 or 12345-6789" }
  validates :message, presence: true, length: { maximum: 2000 }
  validate  :honeypot_empty
  validate  :phone_format, if: -> { phone.present? }

  # Helpers for mail views
  def full_name = "#{first_name} #{last_name}".strip
  def full_address
    [address1, address2.presence, "#{city}, #{state} #{zip}"].compact.join("\n")
  end

  private

  def normalize_fields
    self.email = email.to_s.strip
    self.state = state.to_s.strip.upcase
    self.zip   = zip.to_s.strip
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
