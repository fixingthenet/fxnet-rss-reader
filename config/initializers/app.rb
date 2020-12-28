require 'open-uri'
require 'console_logger'

unless Rails.env.test?
  ActiveRecord::Base.logger=Rails.logger = ConsoleLogger.new
end # during tests log to usual places (file), any other case log to the console



Delayed::Worker.logger = Rails.logger

