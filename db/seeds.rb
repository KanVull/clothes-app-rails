# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

categories = [
  {
    slug: "men",
    name: "Men clothes",
    descriprion: "It's fun to wear some men clothes!",
    ancestry: "/"
  },
  {
    slug: "women",
    name: "Women clothes",
    descriprion: "It's fun to wear some women clothes!",
    ancestry: "/"
  },
  {
    slug: "accessories",
    name: "Accessories",
    descriprion: "It's fun to decorate yourself!",
    ancestry: "/"
  },
  {
    slug: "jackets",
    name: "Jackets",
    descriprion: "It's men jackets!",
    ancestry: "/1/"
  },
  {
    slug: "footwear",
    name: "Footwear",
    descriprion: "It's men footwear!",
    ancestry: "/1/"
  },
  {
    slug: "sneakers",
    name: "Sneakers",
    descriprion: "It's comfortable!",
    ancestry: "/1/5/"
  },
  {
    slug: "shoes",
    name: "Shoes",
    descriprion: "It's comfortable and beauty!",
    ancestry: "/1/5/"
  },
  {
    slug: "socks",
    name: "Socks",
    descriprion: "It's under shoes wear!",
    ancestry: "/1/5/"
  },
  {
    slug: "jackets_1",
    name: "Jackets",
    descriprion: "It's women jackets!",
    ancestry: "/2/"
  },
  {
    slug: "t-shirts",
    name: "T-shirts",
    descriprion: "It's women T-shirts!",
    ancestry: "/2/"
  },
  {
    slug: "backpacks",
    name: "Backpacks",
    descriprion: "Take whatever you want with you everywhere!",
    ancestry: "/3/"
  },
  {
    slug: "pants",
    name: "Pants",
    descriprion: "It's men pants!",
    ancestry: "/1/"
  }
]
categories.each do |category|
  ProductCategory.create!(
    slug: category[:slug],
    name: category[:name],
    description: category[:description],
    ancestry: category[:ancestry]
  )
end

products = [
  {
    name: 'Air 46',
    price: 5600.00,
    quantity: 10,
    description: "Men's Sneakers Flying Woven Casual Sports All-Purpose Men's Shoes Plus Size Shoes Shock Absorbing TPU Outsole",
    published_at: DateTime.new(2024, 2, 28, 13, 30, 0),
    product_category_id: 6
  },
  {
    name: 'Black shirt with monograms adidas Originals',
    price: 6090.00,
    quantity: 10,
    description: 'Soft fabric for sweatshirts. Style and comfort are a way of life.',
    published_at: DateTime.new(2024, 2, 28, 14, 30, 0),
    product_category_id: 10
  },
  {
    name: 'Blue jacket The North Face',
    price: 23_725.00,
    quantity: 10,
    description: 'Smooth fabric. Waterproof coating. Light and warm down filling.',
    published_at: DateTime.new(2024, 2, 28, 13, 30, 0),
    product_category_id: 9
  },
  {
    name: 'Brown sport oversized-top ASOS DESIGN',
    price: 3390.00,
    quantity: 10,
    description: 'Plush texture material. Comfortable and soft.',
    published_at: DateTime.new(2024, 2, 28, 13, 30, 0),
    product_category_id: 10
  },
  {
    name: 'Black backpack Nike Heritage',
    price: 2340.00,
    quantity: 10,
    description: 'Thick fabric. Lightweight material.',
    published_at: DateTime.new(2024, 2, 28, 13, 30, 0),
    product_category_id: 11
  },
  {
    name: 'Dr Martens 1461 Bex 3-Eye Platform Black Shoes',
    price: 13_590.00,
    quantity: 10,
    description: 'Smooth leather upper. Natural material.',
    published_at: DateTime.new(2024, 2, 28, 14, 30, 0),
    product_category_id: 7
  },
  {
    name: 'ASOS DESIGN wide leg formal trousers in navy',
    price: 2890.00,
    quantity: 10,
    description: 'Lightweight, stretchy seersucker textured fabric.',
    published_at: DateTime.new(2024, 2, 28, 13, 30, 0),
    product_category_id: 12
  },
  {
    name: 'Dr. Martens',
    price: 5670.00,
    quantity: 10,
    description: "New",
    published_at: DateTime.new(2024, 3, 3, 13, 30),
    product_category_id: 6
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
