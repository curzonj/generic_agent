module GenericAgent
  class Agent
    include Utilities

    class << self

      def instances
        @instances ||= []
      end

      def load_from(path, namespace=[])
        @namespace = namespace.dup.freeze
        instance_eval(File.read(path))
      end

      def resolve_name(name)
        [ @namespace, name ].flatten.compact.join('.')
      end
    end

    def initialize(opts, &block)
      @opts = opts
      @proc = block
    end

    def name
      @opts[:name]
    end

    def timeout_length
      num = @opts[:timeout].to_i
      (1 <= num || num <= 60) ? num : 5
    end

  end
end
