require 'eventmachine'

module GenericAgent
  class LocalScheduler
    include Utilities

    def initialize(instance)
      @instance = instance
    end

    def shutdown_em
      log.info "Shutting down..."
      EM.stop
    end

    def run
      EM.run do
        trap("INT") { shutdown_em }

        @instance.agents.each do |agent|
          case agent
          when Periodic
            agent.run

            log.debug "Scheduling #{agent.name} every #{agent.interval} seconds"
            EventMachine::PeriodicTimer.new(agent.interval) do
              EM.defer { agent.run }
            end
          else
            log.debug "Received unknown #{agent.inspect}"
            raise NotImplementedError
          end
        end

        log.debug "All agents scheduled, up and running..."
      end
    end

  end
end
