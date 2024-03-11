require "rails_helper"

RSpec.describe Tradeline do
  describe "validation" do
    let(:name) { "Kyle's Credit Card Company" }
    let(:amount) { 5090.12 }
    let(:tradeline) { Tradeline.create(name: name, amount: amount) }

    context "when name" do
      context "is non-empty string" do
        it "passes validation" do
          expect(tradeline.valid?).to be(true)
        end
      end

      context "is empty string" do
        let(:name) { "" }
        it "fails validation" do
          expect(tradeline.valid?).to be(false)
        end
      end

      context "is nil" do
        let(:name) { nil }
        it "fails validation" do
          expect(tradeline.valid?).to be(false)
        end
      end

      context "is not a string" do
        let(:name) { {hello: 123} }
        it "coereces to string" do
          expect(tradeline.name).to eq(name.to_s)
          expect(tradeline.valid?).to eq(true)
        end
      end
    end

    context "when amount" do
      context "is less than #{Tradeline::MIN_AMOUNT}" do
        let(:amount) { Tradeline::MIN_AMOUNT - 1 }
        it("fails validation") do
          expect(tradeline.valid?).to eq(false)
        end
      end

      context "is more than #{Tradeline::MAX_AMOUNT}" do
        let(:amount) { Tradeline::MAX_AMOUNT + 1 }
        it("fails validation") do
          expect(tradeline.valid?).to eq(false)
        end
      end

      context "is between #{Tradeline::MIN_AMOUNT} and #{Tradeline::MAX_AMOUNT}" do
        let(:amount) { Tradeline::MIN_AMOUNT + 20 }
        it("passes validation") do
          expect(tradeline.valid?).to eq(true)
        end
      end
    end
  end
end
