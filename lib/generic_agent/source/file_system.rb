class FileSystemSource

  # TODO watch the path and notify of updates

  def initialize(path)
    @path = path
    @checks
  end

  def checks(&block)
    Dir[File.join(@path, '**/*.rb')].each do |file|
      klass = Class.new(Check).tap {|check| check.load_from(file) }
      klass.checks.each(&block)
    end
  end

end
