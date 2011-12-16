require 'timeout'

module GenericAgent
  class Periodic < Agent

    def self.every(interval, name=nil, opts={}, &block)
      opts, name = name, nil if name.is_a?(Hash)
      opts.merge!(name: resolve_name(name))

      instances << new(interval, opts, &block)
    end

    attr_reader :interval, :opts

    def initialize(interval, opts, &block)
      @interval = interval
      super(opts, &block)
    end

    def run
      timeout timeout_length do
        instance_eval(&@proc)
      end
    rescue
      report(:failed, $!.message)
    end

    protected

    def report(status, message)
      log.info "status is #{status}: #{message}"
    end

  end
end
