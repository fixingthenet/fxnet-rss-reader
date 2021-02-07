require 'open-uri'
require 'console_logger'
require 'fxnet/graphiti/controller'

unless Rails.env.test?
  ActiveRecord::Base.logger=Rails.logger = ConsoleLogger.new
end # during tests log to usual places (file), any other case log to the console



Delayed::Worker.logger = Rails.logger
#Delayed::Worker.destroy_failed_jobs = false
#Delayed::Worker.sleep_delay = 60
#Delayed::Worker.max_attempts = 3
#Delayed::Worker.max_run_time = 5.minutes
#Delayed::Worker.read_ahead = 10
#Delayed::Worker.default_queue_name = 'default'
#Delayed::Worker.delay_jobs = !Rails.env.test?
#Delayed::Worker.raise_signal_exceptions = :term
