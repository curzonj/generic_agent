require 'rubygems'
require 'bundler'

ENV['BUNDLE_GEMFILE'] = File.expand_path('../../Gemfile', __FILE__)
$LOAD_PATH << File.dirname(__FILE__)

Bundler.setup

require 'eventmachine'
require 'generic_agent'

