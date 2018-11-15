class Season < ApplicationRecord
  validates_presence_of :name, :number

  before_validation :set_season_name


  private

  def set_season_name
    self.name = "Season #{self.number}"
  end
 
end
