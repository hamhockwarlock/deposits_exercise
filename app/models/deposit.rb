class Deposit < ApplicationRecord
  belongs_to :tradeline
  validate :validate_deposit_does_not_exceed_tradeline
  validate :validate_tradeline_older_than_deposit
  validates :amount, numericality: {greater_than: 0, less_than: 1_000_000.00, message: "must be a decimal value greater than 0 and less than 1,000,000.00"}

  after_create :subtract_deposit_from_tradeline
  DEPOSIT_AMOUNT_LESS_THAN_TRADELINE_MESSAGE = "must be less than tradeline amount".freeze
  DEPOSIT_TRANSACTION_BEFORE_TRADELINE_MESSAGE = "must be after the tradeline's creation date".freeze

  private

  def validate_deposit_does_not_exceed_tradeline
    errors.add(:amount, DEPOSIT_AMOUNT_LESS_THAN_TRADELINE_MESSAGE) if amount.present? && amount > tradeline.amount
  end

  def validate_tradeline_older_than_deposit
    errors.add(:transaction_time, DEPOSIT_TRANSACTION_BEFORE_TRADELINE_MESSAGE) if transaction_time <= tradeline.created_at
  end

  def subtract_deposit_from_tradeline
    tradeline.amount -= amount if transaction_time.utc <= Time.now.utc
    tradeline.save!
  end
end
