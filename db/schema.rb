# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091024182902) do

  create_table "accomodations", :force => true do |t|
    t.string "title"
  end

  create_table "countries", :force => true do |t|
    t.string "title"
  end

  create_table "departure_cities", :force => true do |t|
    t.string "title"
  end

  create_table "hotel_categories", :force => true do |t|
    t.string "title"
  end

  create_table "meals", :force => true do |t|
    t.string "title"
  end

  create_table "operator_accomodations", :force => true do |t|
    t.integer "accomodation_id"
    t.string  "operator_code"
    t.string  "accomodation_code"
  end

  create_table "operator_countries", :force => true do |t|
    t.integer "country_id"
    t.string  "operator_code"
    t.string  "country_code"
  end

  create_table "operator_departure_cities", :force => true do |t|
    t.integer "departure_city_id"
    t.string  "operator_code"
    t.string  "departure_city_code"
  end

  create_table "operator_hotel_categories", :force => true do |t|
    t.integer "hotel_category_id"
    t.string  "operator_code"
    t.string  "hotel_category_code"
  end

  create_table "operator_meals", :force => true do |t|
    t.integer "meal_id"
    t.string  "operator_code"
    t.string  "meal_code"
  end

  create_table "operator_resorts", :force => true do |t|
    t.integer "resort_id"
    t.string  "operator_code"
    t.string  "resort_code"
    t.integer "country_id"
  end

  create_table "resorts", :force => true do |t|
    t.string  "title"
    t.integer "country_id"
  end

  create_table "searches", :force => true do |t|
    t.integer "country_id"
    t.integer "resort_id"
    t.integer "hotel_id"
    t.integer "departure_city_id"
    t.date    "date_from"
    t.date    "date_till"
    t.integer "nights"
    t.integer "hotel_category_id"
    t.integer "meal_id"
    t.integer "accomodation_id"
    t.float   "price_from"
    t.float   "price_to"
  end

end
