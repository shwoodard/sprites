require "sprites/version"
require 'sprites/application'
require 'sprites/configuration'

module Sprites
  class << self
    def application
      @application ||= Application.new(configuration)
    end

    def configure(&blk)
      @configuration ||= Configuration.new
      @configuration.configure(&blk) if block_given?
      @configuration
    end
    alias_method :configuration, :configure
  end
end
