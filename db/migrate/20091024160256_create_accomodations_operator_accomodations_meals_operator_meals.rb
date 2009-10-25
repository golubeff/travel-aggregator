require 'active_record/fixtures'


class CreateAccomodationsOperatorAccomodationsMealsOperatorMeals < ActiveRecord::Migration
  def self.up
    create_table :accomodations do |t|
      t.string :title
    end

    create_table :operator_accomodations do |t|
      t.integer :accomodation_id
      t.string :operator_code
      t.string :accomodation_code
    end
    create_table :meals do |t|
      t.string :title
    end

    create_table :operator_meals do |t|
      t.integer :meal_id
      t.string :operator_code
      t.string :meal_code
    end

    Fixtures.create_fixtures 'fixtures', [
      'accomodations', 'operator_accomodations',
      'meals', 'operator_meals'
    ]
    
  end

  def self.down
    drop_table :accomodations
    drop_table :operator_accomodations
    drop_table :meals
    drop_table :operator_meals
  end
end
