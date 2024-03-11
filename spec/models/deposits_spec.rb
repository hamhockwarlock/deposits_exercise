require "rails_helper"

RSpec.describe Deposit do
  let(:amount) { 1947.12 }
  let(:transaction_time) { DateTime.new(2022, 1, 1) }
  let(:tradeline) { create(:tradeline) }
  let(:tradeline_id) { tradeline.id }
  let(:deposit) { Deposit.create(amount: amount, transaction_time: transaction_time, tradeline_id: tradeline_id) }

  describe "validation" do
    context "when amount" do
      context "is less than #{Deposit::MIN_AMOUNT}" do
        let(:amount) { Deposit::MIN_AMOUNT - 1 }
        it("fails validation") do
          expect(deposit.valid?).to eq(false)
        end
      end

      context "is more than #{Deposit::MAX_AMOUNT}" do
        let(:amount) { Deposit::MAX_AMOUNT + 1 }
        it("fails validation") do
          expect(deposit.valid?).to eq(false)
        end
      end

      context "is between #{Deposit::MIN_AMOUNT} and #{Deposit::MAX_AMOUNT}" do
        let(:amount) { Deposit::MIN_AMOUNT + 20 }
        it("passes validation") do
          expect(deposit.valid?).to eq(true)
        end
      end

      context "is more than tradeline" do
        before { allow_any_instance_of(Tradeline).to receive(:amount).and_return(10) }
        let(:amount) { 11 }
        it("fails validation") do
          expect(deposit.valid?).to eq(false)
        end
      end

      context "is less than tradeline" do
        before { allow_any_instance_of(Tradeline).to receive(:amount).and_return(10) }
        let(:amount) { 9 }
        it("passes validation") do
          expect(deposit.valid?).to eq(true)
        end
      end
    end

    context "when transaction_time" do
      context("is earlier than tradeline") do
        let(:transaction_time) { DateTime.new(1999, 1, 1) }
        it("fails validation") do
          expect(deposit.valid?).to eq(false)
        end
      end

      context("is later than tradeline") do
        let(:transaction_time) { DateTime.new(2222, 1, 1) }
        it("passes validation") do
          expect(deposit.valid?).to eq(true)
        end
      end
    end
  end

  describe "after_save" do
    context("transaction_time is not in the future") do
      let(:transaction_time) { DateTime.now - 1.hour }
      before { allow_any_instance_of(Deposit).to receive(:can_subtract_deposit?).and_return(true) }
      it("updates the tradeline amount") do
        expect_any_instance_of(Tradeline).to receive(:save)
        Deposit.create(transaction_time: transaction_time, amount: 15.0, tradeline_id: tradeline.id)
      end
    end

    context("transaction_time is in the future") do
      let(:transaction_time) { DateTime.now - 1.hour }
      before { allow_any_instance_of(Deposit).to receive(:can_subtract_deposit?).and_return(false) }
      it("does not update the tradeline amount") do
        expect_any_instance_of(Tradeline).not_to receive(:save)
        Deposit.create(transaction_time: transaction_time, amount: 15.0, tradeline_id: tradeline.id)
      end
    end
  end
end
