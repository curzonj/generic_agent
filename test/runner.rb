#!/usr/bin/env ruby

require File.expand_path('../lib/env', __FILE__)

configs_path = File.expand_path('../checks', __FILE__)
source = FileSystemSource.new(configs_path)
scheduler = LocalScheduler.new(source) # or nats

scheduler.run
