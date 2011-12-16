require 'eventmachine'

module GenericAgent
  class LocalScheduler
    include Utilities

    def initialize(source)
      @source = source
    end

    def shutdown_em
      log.info "Shutting down..."
      EM.stop
    end

    def run
      EM.run do
        trap("INT") { shutdown_em }

        @source.periodic do |instance|
          instance.run

          log.info "Scheduling #{instance.name} every #{instance.interval} seconds"
          EventMachine::PeriodicTimer.new(instance.interval) do
            EM.defer { instance.run }
          end
        end
      end
    end

  end
end
