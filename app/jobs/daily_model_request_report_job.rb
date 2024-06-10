class DailyModelRequestReportJob < ApplicationJob
  queue_as :default

  def perform(email)
    yesterday_requests = ModelRequest.where(created_at: 1.day.ago.all_day)
    ModelRequestMailer.daily_report(yesterday_requests, email).deliver_now
  end
end
