class Resort < ActiveRecord::Base
  include OperatorReference
  belongs_to :country
end
