class DepositsController < ApplicationController
  before_action -> { find_tradeline(params[:tradeline_id]) }, only: %i[create]
  before_action :validate_transaction_time_is_iso8601
  TRANSACTION_TIME_MUST_BE_ISO8601_ERROR = "Transaction time must adhere to the ISO8601 format (e.g. 2024-01-01T01:01:01Z)".freeze

  def create
    deposit = @tradeline.deposits.create!(create_params)
    render json: {deposit: deposit}, status: :created
  end

  private

  def create_params
    params.require(:deposit).permit(:amount, :transaction_time)
  end

  def validate_transaction_time_is_iso8601
    DateTime.iso8601(create_params[:transaction_time])
  rescue Date::Error
    render json: {message: VALIDATION_FAILED_MESSAGE, errors: [TRANSACTION_TIME_MUST_BE_ISO8601_ERROR]}, status: :unprocessable_entity
  end
end
