require 'active_record/fixtures'


class AddCountryIdToOperatorResort < ActiveRecord::Migration
  def self.up
    add_column :operator_resorts, :country_id, :integer

    Fixtures.create_fixtures 'fixtures', [
'operator_resorts'
    ]

  end

  def self.down
    remove_column :operator_resorts, :country_id
  end


end
