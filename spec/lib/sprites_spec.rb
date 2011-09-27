require 'spec_helper'

describe Sprites do
  context 'self.application' do
    it 'should return an application' do
      Sprites.application.should be_a(Sprites::Application)
    end
  end

  context 'self.configure' do
    it 'should congfigure the application' do
      Sprites.configure do
        backend :rmagick
      end

      Sprites.configuration.backend.should == :rmagick
    end
  end
end
