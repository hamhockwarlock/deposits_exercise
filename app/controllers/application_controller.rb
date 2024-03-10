class ApplicationController < ActionController::API
  VALIDATION_FAILED_MESSAGE = "Validation failed".freeze
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :invalid

  def find_tradeline(id)
    @tradeline = Tradeline.find(id)
  end

  private

  def not_found
    render json: "not_found", status: :not_found
  end

  def invalid(entity)
    render json: {message: VALIDATION_FAILED_MESSAGE, errors: entity.record.errors.full_messages}, status: :unprocessable_entity
  end
end
