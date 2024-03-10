class Tradeline < ApplicationRecord
  validates :amount, numericality: {greater_than: 0, less_than_or_equal_to: 999_999.99, message: "must be a decimal value greater than 0"}
  has_many :deposits, dependent: :destroy
end
