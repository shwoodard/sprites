require 'spec_helper'
require 'sprites/sprite_generator'

describe SpriteGenerator do

  context 'self.current' do
    it 'should return a SpriteGenerator' do
      SpriteGenerator.current.should be_a(SpriteGenerator)
    end
  end

end
