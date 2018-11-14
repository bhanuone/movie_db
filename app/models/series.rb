class Series < ApplicationRecord
  # belongs_to :genre

  validates_presence_of :name
  validates_uniqueness_of :name

end
