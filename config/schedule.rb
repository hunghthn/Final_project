# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
every :day, at: '8:00 am' do
    runner "DailyModelRequestReportJob.perform_now('carvietnam01@gmail.com')"
  end

every :monday, at: '5am' do
  # rake 'db:update_models'
  # rake 'db:update_trims'
  # rake 'db:safety_technologies'
  # rake 'db:driving_assistances'
  # rake 'db:interiors'
  # rake 'db:exteriors'
  # rake 'db:suspension_brakes'
  # rake 'db:size_weights'
  # rake 'db:engine_transmissions'
end