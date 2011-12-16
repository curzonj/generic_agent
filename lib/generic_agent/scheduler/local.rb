class LocalScheduler < Scope

  def initialize(source)
    @source = source
  end

  def run
    EM.run do
      @source.checks do |check|
        check.run

        log.info "Scheduling #{check.name} every #{check.every} seconds"
        EventMachine::PeriodicTimer.new(check.every) do
          EM.defer { check.run }
        end
      end
    end
  end

end
