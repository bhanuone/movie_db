class Season < ApplicationRecord
  validates_presence_of :name, :number
end
