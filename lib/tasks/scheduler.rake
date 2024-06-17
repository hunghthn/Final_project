
desc "Send daily model request report"
task :daily_model_request_report => :environment do
  DailyModelRequestReportJob.perform_now('carvietnam01@gmail.com')
end
