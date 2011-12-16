require 'thor'

module GenericAgent
  class CLI < Thor
    include Thor::Actions

    check_unknown_options!
    class_option "verbose",  :type => :boolean, :banner => "Enable verbose output mode", :aliases => "-v"

    def initialize(*)
      super
      Utilities.debug! if options['verbose']
    end

    desc "test", "run a set of checks"
    def test

      instance = GenericAgent.configure

      # In the future this could be a NATS distributed scheduler
      LocalScheduler.new(instance).run
    end

  end
end
