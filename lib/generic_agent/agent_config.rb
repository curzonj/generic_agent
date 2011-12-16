module GenericAgent
  class AgentConfig
    include Utilities

    class << self
      def directory=(path)
        @directory = path
      end

      def directory
        return @directory if defined? @directory

        config_dir = File.expand_path('config', GenericAgent.root)
        @directory = config_dir if File.directory?(config_dir)
      end

      def [](filename)
        @configs ||= {}
        @configs[filename] ||= load_file(filename)
      end

      def get(*components)
        components.inject(self) do |set, part|
          if set.nil?
            return nil
          elsif set == self || set.is_a?(Hash)
            next set[part.to_s]
          else
            raise ArgumentError, "#get can only traverse Hashes: #{set.inspect}"
          end
        end
      end

      def load_file(filename)
        raw = File.read(File.join(directory, "#{filename}.yml"))
        all = YAML.load(ERB.new(raw).result)
        config = all[GenericAgent.env] || all
        config.freeze

        config
      rescue Errno::ENOENT => e
        log.error "AgentConfig: '#{directory}/#{filename}' not found"

        {}
      end

    end
  end
end
