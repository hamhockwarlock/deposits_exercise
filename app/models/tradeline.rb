class Tradeline < ApplicationRecord
  MIN_AMOUNT = 0.01
  MAX_AMOUNT = 999_999.99

  validates :amount, numericality: {greater_than_or_equal_to: MIN_AMOUNT, less_than_or_equal_to: MAX_AMOUNT, message: "must be a decimal value greater than 0"}
  validates :name, presence: true
  has_many :deposits, dependent: :destroy
end
