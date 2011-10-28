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
        sprites_path 'public/sprites'
      end

      Sprites.configuration.sprites_path.should == 'public/sprites'
    end
  end
end
