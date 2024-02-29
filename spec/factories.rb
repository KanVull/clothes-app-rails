FactoryBot.define do
  factory :product do
    name { "Sample Product" }
    published_at { nil }
    price { 1 }
    quantity { 10 }
    
    product_category
  end
  
  factory :product_category do
    name { "Sample Category" }
  end
end
