class NotifierJob < ActiveJob::Base
  queue_as :notifier

  def perform
    User.joins(:series).distinct.find_each do |user|
      new_episodes_present = user.series.joins(:episodes).where(episodes: {air_date: Date.today}).any?
      if new_episodes_present
        UserMailer.new_episodes_email(user).deliver_now
      end
    end
  end

end