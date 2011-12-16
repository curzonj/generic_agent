require "generic_agent/version"
require 'generic_agent/utilities'
require 'generic_agent/agent_config'
require 'generic_agent/loader'
require 'generic_agent/agent'
require 'generic_agent/periodic'
require 'generic_agent/scheduler/local'

module GenericAgent

  class << self

    attr_accessor :instance

    def configure
      self.instance = Loader.new.tap do |loader|
        yield loader if block_given?
        loader.default_loading
      end
    end

    # Use @instance delegations sparingly inside the framework as 
    # that ties usage to global variables
    def method_missing(sym, *args)
      if instance && instance.respond_to?(sym)
        instance.send(sym, *args)
      else
        super
      end
    end
  end
end
