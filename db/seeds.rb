10.times do
  Tradeline.create!(
    name: Faker::Commerce.product_name,
    amount: Faker::Commerce.price(range: 0..100_000.99)
  )
end
