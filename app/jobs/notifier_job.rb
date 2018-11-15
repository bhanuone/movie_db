class NotifierJob < ActiveJob::Base
  queue_as :default

  def perform
    puts "Notifying users"
  end

end