# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_240_227_101_611) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'product_categories', force: :cascade do |t|
    t.string 'name', limit: 128, null: false
    t.text 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['name'], name: 'index_product_categories_on_name', unique: true
  end

  create_table 'products', force: :cascade do |t|
    t.string 'name', limit: 128, null: false
    t.decimal 'price', precision: 7, scale: 2, null: false
    t.integer 'quantity', default: 0, null: false
    t.text 'description'
    t.string 'image'
    t.datetime 'published_at'
    t.bigint 'product_category_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['name'], name: 'index_products_on_name', unique: true
    t.index ['product_category_id'], name: 'index_products_on_product_category_id'
  end

  add_foreign_key 'products', 'product_categories'
end
