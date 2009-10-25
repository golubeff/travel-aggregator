require 'active_record/fixtures'

class CreateSearches < ActiveRecord::Migration
  def self.up
    create_table :countries do |t|
      t.string :title 
    end

    create_table :operator_countries do |t|
      t.integer :country_id
      t.string :operator_code
      t.string :country_code
    end

    create_table :resorts do |t|
      t.string :title
      t.integer :country_id
    end

    create_table :operator_resorts do |t|
      t.integer :resort_id
      t.string :operator_code
      t.string :resort_code
    end

    create_table :departure_cities do |t|
      t.string :title
    end

    create_table :operator_departure_cities do |t|
      t.integer :departure_city_id
      t.string :operator_code
      t.string :departure_city_code
    end

    create_table :hotel_categories do |t|
      t.string :title
    end

    create_table :operator_hotel_categories do |t|
      t.integer :hotel_category_id
      t.string :operator_code
      t.string :hotel_category_code
    end

    create_table :searches do |t|
      t.integer :country_id
      t.integer :resort_id
      t.integer :hotel_id
      t.integer :departure_city_id
      t.date :date_from
      t.date :date_till
      t.integer :nights
      t.integer :hotel_category_id
      t.integer :meal_id
      t.integer :accomodation_id
      t.float :price_from
      t.float :price_to
    end

    Fixtures.create_fixtures 'fixtures', [
      'hotel_categories', 'operator_hotel_categories',
      'departure_cities', 'operator_departure_cities',
      'resorts', 
      'countries', 'operator_countries'
    ]
  end

  def self.down
    drop_table :searches
    #drop_table :accomodations
    #drop_table :operator_accomodations
    #drop_table :meals
    #drop_table :operator_meals
    drop_table :hotel_categories
    drop_table :operator_hotel_categories
    drop_table :departure_cities
    drop_table :operator_departure_cities
    drop_table :resorts
    drop_table :operator_resorts
    drop_table :countries
    drop_table :operator_countries
  end
end
