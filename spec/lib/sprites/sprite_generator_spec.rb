require 'spec_helper'
require 'pathname'

describe SpriteGenerator do
  include Magick

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

  context '#generate' do
    it 'should generate a sprite' do
      config = Configuration.new

      config.sprites_path('tmp/images/sprites')
      config.sprite_stylesheets_path('tmp/stylesheets/sprites')
      config.sprite_pieces_path('spec/fixtures/sprite_images')

      sprites = Sprites::Sprites.new

      sprites.add(:foo) do
        sprite_piece 'foo/foo.png' => '.foo'
      end

      SpriteGenerator.current(config).generate(sprites)

      Pathname.new('tmp/images/sprites/foo.png').should exist
    end
  end

  describe 'when generating stylesheets' do
    it 'should generate a style sheet' do
      config = Configuration.new

      config.sprites_path('tmp/images/sprites')
      config.sprite_stylesheets_path('tmp/stylesheets/sprites')
      config.sprite_pieces_path('spec/fixtures/sprite_images')

      sprites = Sprites::Sprites.new

      sprites.add(:foo) do
        sprite_piece 'foo/foo.png' => '.foo'
      end

      SpriteGenerator.current(config).generate(sprites)

      Pathname.new('tmp/stylesheets/sprites/foo.css').should exist
    end
  end
end
