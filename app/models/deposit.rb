class Deposit < ApplicationRecord
  belongs_to :tradeline
  DEPOSIT_AMOUNT_LESS_THAN_TRADELINE_MESSAGE = "must be less than tradeline amount".freeze
  DEPOSIT_TRANSACTION_BEFORE_TRADELINE_MESSAGE = "must be after the tradeline's creation date".freeze
  DEPOSIT_NUMERICALITY_RANGE_MESSAGE = "must be a decimal value greater than 0 and less than 1,000,000.00".freeze
  MIN_AMOUNT = 0.01
  MAX_AMOUNT = 999_999.99

  validate :validate_deposit_does_not_exceed_tradeline
  validate :validate_tradeline_older_than_deposit
  validates :amount, numericality: {greater_than_or_equal_to: MIN_AMOUNT, less_than_or_equal_to: MAX_AMOUNT, message: DEPOSIT_NUMERICALITY_RANGE_MESSAGE}

  after_save :subtract_deposit_from_tradeline, if: :can_subtract_deposit?

  private

  def validate_deposit_does_not_exceed_tradeline
    errors.add(:amount, DEPOSIT_AMOUNT_LESS_THAN_TRADELINE_MESSAGE) if amount.present? && amount > tradeline.amount
  end

  def validate_tradeline_older_than_deposit
    errors.add(:transaction_time, DEPOSIT_TRANSACTION_BEFORE_TRADELINE_MESSAGE) if transaction_time.before?(tradeline.created_at)
  end

  def subtract_deposit_from_tradeline
    tradeline.amount -= amount
    tradeline.save(validate: false)
  end

  def can_subtract_deposit?
    transaction_time.utc.before?(Time.now.utc)
  end
end
