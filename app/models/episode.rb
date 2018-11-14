class Episode < ApplicationRecord
  belongs_to :series
  belongs_to :season

  validates_presence_of :title
  validates_presence_of :air_date

end
