module GenericAgent
  class Loader

    attr_writer :root, :env

    def root
      @root ||= Dir.pwd
    end

    def env
      @env ||= 'development'
    end

    def agents
      @agents ||= []
    end

    def klasses
      @klasses ||= []
    end

    def default_loading
      lib_dir = File.expand_path('lib', root)
      $LOAD_PATH << lib_dir if File.directory?(lib_dir)

      load_agents(File.expand_path('agents', root)) if agents.empty?
    end

    def new_agent(superclass)
      klass = Class.new(superclass)
      klasses << klass
      klass
    end

    def load_agents(path)
      each_source_file(path) do |file, segments|
        klass = new_agent(Periodic)
        klass.load_from(file, segments)

        @agents << klass.instances
      end
    end

    def each_source_file(path)
      Dir[File.join(path, '**/*.rb')].each do |file|
        segments = file.chomp('.rb').
                   gsub(path, '').
                   split('/').
                   reject {|s| s.empty? }

        yield file, segments
      end
    end
  end
end
