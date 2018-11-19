class Episode < ApplicationRecord
  belongs_to :series
  belongs_to :season

  validates_presence_of :title
  validates_presence_of :air_date

  scope :todays_episodes, -> { where(air_date: Date.today) }

  def episode_code
    'S%02iE%02i' % [self.season.number, self.episode_number]
  end

  def formated_air_date
    self.air_date.strftime('%d %b, %Y')
  end

end
