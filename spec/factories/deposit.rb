FactoryBot.define do
  factory :deposit do
    amount { 10.15 }
    transaction_time { DateTime.new(2024, 1, 1) }
    created_at { DateTime.new(2021, 5, 1) }
    updated_at { DateTime.new(2022, 5, 1) }
  end
end
