require 'logger'

module Utilities

  def self.included(base)
    base.send(:extend, ClassMethods)
  end

  def self.log
    @logger ||= Logger.new(STDERR)
  end

  module ClassMethods

    def log
      @logger || Utilities.log
    end

  end

  def log
    @logger || self.class.log
  end

end
