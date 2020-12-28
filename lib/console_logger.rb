class ConsoleLogger < Logger
  def initialize(silencer: true)
    @silencer=silencer
    super(STDOUT)
    STDOUT.sync=true
    self.formatter = proc do |severity, datetime, progname, msg|
      "#{datetime} [#{severity}] #{msg}\n"
    end
    self.log_level=ENV["LOGGING_LEVEL"] || 'debug'
  end

  def silence(temporary_level = Logger::ERROR)
    if @silencer
      begin
        old_logger_level, self.level = level, temporary_level
        yield self
      ensure
        self.level = old_logger_level
      end
    else
      yield self
    end
  end
  
  def log_level
      level
  end

  def log_level=(lvl)
    self.level = lvl
  end
end
