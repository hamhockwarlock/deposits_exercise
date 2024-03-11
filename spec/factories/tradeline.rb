FactoryBot.define do
  factory :tradeline do
    name { "Some Credit Card" }
    amount { 3223.54 }
    created_at { DateTime.new(2021, 5, 1) }
    updated_at { DateTime.new(2022, 5, 1) }
  end
end
