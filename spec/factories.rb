FactoryBot.define do
  factory :random_product, class: Product do
    name          { Faker::Commerce.product_name }
    published_at  { Faker::Date.between(from: 7.days.ago, to: 2.days.from_now) }
    price         { Faker::Commerce.price(range: 1000..10000.0) }
    quantity      { Faker::Number.number(digits: 2) }
    
    association :product_category, factory: :random_product_category
  end
  
  factory :random_product_category, class: ProductCategory do
    name { Faker::Commerce.material }
  end
end
