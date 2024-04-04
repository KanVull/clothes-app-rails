FactoryBot.define do
  factory :product, class: Product do
    name          { "#{Faker::Commerce.product_name}_#{Faker::Number.number(digits: 5)}" }
    published_at  { Faker::Date.between(from: 7.days.ago, to: Time.zone.now) }
    price         { Faker::Commerce.price(range: 1000..100000.0) }
    quantity      { Faker::Number.number(digits: 2) }

    association :product_category, factory: :product_category
  end

  factory :product_category, class: ProductCategory do
    name { "#{Faker::Commerce.material}_#{Faker::Number.number(digits: 5)}" }
  end

  factory :cart, class: Cart do
    session_key { Faker::Alphanumeric.alphanumeric(number: 10) }
  end

  factory :cart_product, class: CartProduct do
    quantity { Faker::Number.number(digits: 2) }

    cart
    product
  end

  factory :order, class: Order do
    email { Faker::Internet.email }
    shipping_address { Faker::Address.full_address }
  end

  factory :order_product, class: OrderProduct do
    quantity { Faker::Number.number(digits: 2) }
    price_at_purchase { product.price }

    cart
    product
  end

  factory :user, class: User do
    email { Faker::Internet.email }
    password_digest { Faker::Internet.password }
  end
end
