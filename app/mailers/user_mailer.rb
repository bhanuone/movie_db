class UserMailer < ApplicationMailer

  def new_episodes_email(user_id, series_ids)
    puts "Sending email"
    @user = User.find(user_id)
    @series = Series.where(id: series_ids)
    mail(to: @user.email, subject: 'New episodes released this week')
  end
end
