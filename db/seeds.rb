# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

categories = %w[Shoes Pants Shirts Jackets Bags]
categories.each do |category|
  ProductCategory.create!(name: category)
end

products = [
  {
    name: 'Air 46',
    price: 5600.00,
    quantity: 10,
    description: "Men's Sneakers Flying Woven Casual Sports All-Purpose Men's Shoes Plus Size Shoes Shock Absorbing TPU Outsole",
    published_at: DateTime.new(2024, 2, 28, 13, 30, 0),
    product_category_id: 1
  },
  {
    name: 'Black shirt with monograms adidas Originals',
    price: 6090.00,
    quantity: 10,
    description: 'Soft fabric for sweatshirts. Style and comfort are a way of life.',
    published_at: DateTime.new(2024, 2, 28, 14, 30, 0),
    product_category_id: 3
  },
  {
    name: 'Blue jacket The North Face',
    price: 23_725.00,
    quantity: 10,
    description: 'Smooth fabric. Waterproof coating. Light and warm down filling.',
    published_at: DateTime.new(2024, 2, 28, 13, 30, 0),
    product_category_id: 4
  },
  {
    name: 'Brown sport oversized-top ASOS DESIGN',
    price: 3390.00,
    quantity: 10,
    description: 'Plush texture material. Comfortable and soft.',
    published_at: DateTime.new(2024, 2, 28, 13, 30, 0),
    product_category_id: 4
  },
  {
    name: 'Black backpack Nike Heritage',
    price: 2340.00,
    quantity: 10,
    description: 'Thick fabric. Lightweight material.',
    published_at: DateTime.new(2024, 2, 28, 13, 30, 0),
    product_category_id: 5
  },
  {
    name: 'Dr Martens 1461 Bex 3-Eye Platform Black Shoes',
    price: 13_590.00,
    quantity: 10,
    description: 'Smooth leather upper. Natural material.',
    published_at: DateTime.new(2024, 2, 28, 14, 30, 0),
    product_category_id: 1
  },
  {
    name: 'ASOS DESIGN wide leg formal trousers in navy',
    price: 2890.00,
    quantity: 10,
    description: 'Lightweight, stretchy seersucker textured fabric.',
    published_at: DateTime.new(2024, 2, 28, 13, 30, 0),
    product_category_id: 2
  }
]

products.each do |product|
  Product.create!(
    name: product[:name],
    price: product[:price],
    quantity: product[:quantity],
    description: product[:description],
    published_at: product[:published_at],
    product_category_id: product[:product_category_id]
  )
end
