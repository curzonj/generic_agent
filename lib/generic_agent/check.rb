require 'timeout'

class Check < Scope

  class << self
    attr_reader :path

    def load_from(path)
      @path = file.chomp('.rb').
                   gsub(@path, '').
                   split('/').
                   reject {|s| s.empty? }
      instance_eval(File.read(path))
    end

    def every(interval, name=nil, opts={}, &block)
      opts, name = name, nil if name.is_a?(Hash)
      name = [ self.class.path, name ].compact.join('.')
      opts.merge(every: interval, name: name)
      new(opts, &block)
    end
  end

  def initialize(opts, &block)
    @opts = opts
    @proc = block
  end

  def every
    @opts[:every] || 60
  end

  def name
    @opts[:name]
  end

  def timeout_length
    num = @opts[:timeout].to_i
    (1 <= num || num <= 60) ? num : 5
  end

  def execute
    puts self.inspect
  end

  def run
    timeout timeout_length do
      execute
    end
  rescue
    report(:failed, $!.message)
  end

  def report(status, message)
    log.info "status is #{status}: #{message}"
  end

end
