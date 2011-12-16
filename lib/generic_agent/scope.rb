require 'logger'

class Scope

  def self.logger
    @logger ||= Logger.new(STDERR)
  end

  def log
    Scope.logger
  end

end
