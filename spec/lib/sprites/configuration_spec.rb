require 'spec_helper'
require 'sprites/configuration'

describe Sprites::Configuration do
  let(:config) do
    Sprites::Configuration.new
  end

  context '#sprites_path' do
    it 'should return the default' do
      config.sprites_path.should == 'public/images/sprites'
    end

    it 'should accept an override' do
      config.sprites_path = 'foo'
      config.sprites_path.should == 'foo'
    end
  end

  context '#sprite_stylesheets_path' do
    it 'should return the default' do
      config.sprite_stylesheets_path.should == 'public/stylesheets/sprites'
    end

    it 'should accept an override' do
      config.sprite_stylesheets_path = 'foo'
      config.sprite_stylesheets_path.should == 'foo'
    end
  end

  context '#sprite_stylesheets_path' do
    it 'should return the default' do
      config.sprite_pieces_path.should == 'public/images/sprite_images'
    end

    it 'should accept an override' do
      config.sprite_pieces_path = 'foo'
      config.sprite_pieces_path.should == 'foo'
    end
  end

  context '#configured?' do
    it 'should not be configured if no defaults have changed' do
      Sprites::Configuration.new.should_not be_configured
    end
    
    Sprites::Configuration::FIELDS.each do |field|
      it "should be configured if the #{field} has changed" do
        config = Sprites::Configuration.new
        config.send(:"#{field}=", 'foo')
        config.should be_configured
      end
    end
  end
end
