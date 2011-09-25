require "sprites/version"
require 'sprites/application'

module Sprites
  class << self
    def application
      @application ||= Application.new
    end

    def sprites
      application.sprites
    end
  end
end
