require "rails_helper"

RSpec.describe DepositsController, type: :controller do
  let(:tradeline) { create(:tradeline) }
  let(:amount) { 123.0 }
  let(:transaction_time) { DateTime.new(2022, 1, 1).utc.iso8601 }
  let(:params) do
    {
      tradeline_id: tradeline.id,
      deposit: {
        amount: amount,
        transaction_time: transaction_time
      }
    }
  end

  describe "#create" do
    subject { post :create, params: params, as: :json }
    context "with a valid request" do
      it "responds with a 201" do
        subject
        expect(response).to have_http_status(:created)
      end
    end

    context "with an invalid request" do
      let(:message) { nil }
      let(:errors) { [] }
      let(:expected_response_body) do
        {
          message: message,
          errors: errors
        }
      end
      context "with an invalid transaction time" do
        let(:message) { ApplicationController::VALIDATION_FAILED_MESSAGE }
        let(:errors) { [DepositsController::TRANSACTION_TIME_MUST_BE_ISO8601_ERROR] }
        let(:transaction_time) { nil }
        it "responds with a 422" do
          subject
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it "repsonds with expected response" do
          subject
          expect(response.body).to eq(expected_response_body.to_json)
        end
      end

      context "with a failed validation" do
        let(:amount) { Deposit::MIN_AMOUNT - 1 }
        let(:message) { ApplicationController::VALIDATION_FAILED_MESSAGE }
        let(:errors) { ["Amount #{Deposit::DEPOSIT_NUMERICALITY_RANGE_MESSAGE}"] }
        it "responds with a 422" do
          subject
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it "responds with expected response body" do
          subject
          expect(response.body).to eq(expected_response_body.to_json)
        end
      end

      context "with tradeline that doesn't exist" do
        let(:params) { {tradeline_id: -1} }
        it "responds with a 404" do
          subject
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
