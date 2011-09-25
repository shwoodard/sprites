require 'spec_helper'

describe Sprites do
  context 'self.application' do
    it 'should respond to application' do
      Sprites.should respond_to(:application)
    end

    it 'should return an application' do
      Sprites.application.should be_a(Sprites::Application)
    end
  end
end
