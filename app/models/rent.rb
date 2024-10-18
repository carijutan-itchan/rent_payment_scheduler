class Rent
  include ActiveModel::Model  # Allows the use of validations

  FREQUENCIES = %w[weekly fortnightly monthly].freeze
  PAYMENT_METHODS = [ "Instant", "Credit Card", "Bank Transfer"].freeze

  attr_accessor :rent_amount, :rent_frequency, :rent_start_date, :rent_end_date, :payment_method

  validates :rent_amount, presence: true, numericality: true
  validates :rent_frequency, presence: true, inclusion: { in: FREQUENCIES, message: "%{value} is not a valid rent frequency" }
  validates :payment_method, inclusion: { in: PAYMENT_METHODS, message: "%{value} is not a valid payment method" }, allow_blank: true
  validates :rent_start_date, presence: true # YYYY-MM-DD
  validates :rent_end_date, presence: true # YYYY-MM-DD
  validate :rent_start_date_must_be_a_valid_date
  validate :rent_end_date_must_be_a_valid_date
  validate :end_date_must_be_after_start_date
  
  def initialize(attributes = {})
    @attributes = attributes
    super
  end

  private

  def end_date_must_be_after_start_date
    if rent_end_date <= rent_start_date
      errors.add(:rent_end_date, "must be after the rent start date")
    end
  end

  def rent_end_date_must_be_a_valid_date
    begin
      Date.parse(rent_end_date)
    rescue ArgumentError
      errors.add(:rent_end_date, "must be a valid date")
    end
  end

  def rent_start_date_must_be_a_valid_date
    begin
      Date.parse(rent_start_date)
    rescue ArgumentError
      errors.add(:rent_start_date, "must be a valid date")
    end
  end
end