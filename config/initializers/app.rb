require 'open-uri'
require 'fxnet'

unless Rails.env.test?
  ActionController::Base.logger =
  ActiveRecord::Base.logger =
  Rails.logger =
  Fxnet::ConsoleLogger.new
end # during tests log to usual places (file), any other case log to the console

Delayed::Worker.logger = Rails.logger

#currently only supporting one OIdC IdP
Rails.configuration.cached_app_configuration = nil
Rails.configuration.app_configuration_picker= ->(controller) {
  Rails.configuration.cached_app_configuration ||= AppConfiguration.find(ENV['APP_CONFIGURATION_IDENTIFIER'])
}

#Delayed::Worker.destroy_failed_jobs = false
#Delayed::Worker.sleep_delay = 60
#Delayed::Worker.max_attempts = 3
#Delayed::Worker.max_run_time = 5.minutes
#Delayed::Worker.read_ahead = 10
#Delayed::Worker.default_queue_name = 'default'
#Delayed::Worker.delay_jobs = !Rails.env.test?
#Delayed::Worker.raise_signal_exceptions = :term
