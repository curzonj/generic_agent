require 'logger'

module GenericAgent
  module Utilities

    class << self
      def included(base)
        base.send(:extend, ClassMethods)
      end

      def log=(logger)
        @logger = logger
      end

      def debug!
        log.level = 0
      end

      def log
        @logger ||= Logger.new(STDERR)
      end
    end

    module ClassMethods

      def log
        @logger || Utilities.log
      end

      def config
        AgentConfig
      end

    end

    def config
      AgentConfig
    end

    def log
      @logger || self.class.log
    end

  end
end
