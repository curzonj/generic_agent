module GenericAgent
  class FileSystemSource

    def initialize(path)
      @path = path
      @klasses = {}
    end

    def periodic(&block)
      Dir[File.join(@path, '**/*.rb')].each do |file|
        segments = file.chomp('.rb').
                   gsub(@path, '').
                   split('/').
                   reject {|s| s.empty? }

        klass = Class.new(Periodic)
        klass.load_from(file, segments)
        @klasses[file] = klass

        klass.instances.each(&block)
      end
    end

  end
end
