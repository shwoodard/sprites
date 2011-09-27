require 'spec_helper'

describe SpriteGenerator do

  context 'self.current' do
    it 'should return a SpriteGenerator' do
      SpriteGenerator.current.should be_a(SpriteGenerator)
    end

    SpriteGenerator::SPRITE_GENERATORS.keys.each do |curr_backend|
      it "should return a SpriteGenerator for backend #{curr_backend} if configured to do so" do
        config = Configuration.new.backend(curr_backend)
        SpriteGenerator.current(config).should be_a(SpriteGenerator::SPRITE_GENERATORS[curr_backend])
      end
    end
  end

end
