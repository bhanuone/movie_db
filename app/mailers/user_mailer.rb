class UserMailer < ApplicationMailer

  def new_episodes_email(user)
    puts "Sending email"
    @user = user
    @data = {}
    new_episode_series = user.series.joins(:episodes).where(episodes: {air_date: Date.today})
    new_episode_series.find_each do |series|
      todays_episode = series.episodes.todays_episodes.first
      @data[series.name] = "#{todays_episode.title}(#{todays_episode.episode_code})"
    end
    mail(to: @user.email, subject: 'New episodes released today')
  end
end
