class NotifierJob < ActiveJob::Base
  queue_as :default

  def perform(user_id, series_ids)
    UserMailer.new_episodes_email(user_id, series_ids).deliver_now
  end

end