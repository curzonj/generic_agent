require 'thor'

module GenericAgent
  class CLI < Thor
    include Thor::Actions

    check_unknown_options!

    desc "test PATH", "run a set of checks from PATH"
    def test(path)
      source = FileSystemSource.new(File.expand_path(path))
      scheduler = LocalScheduler.new(source) # or nats

      scheduler.run
    end

  end
end
