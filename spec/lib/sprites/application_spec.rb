require 'spec_helper'

describe Application do

  after do
    Sprites.application.sprites.clear
  end

  context "#define" do
    it 'should respond to define' do
      Application.new.should respond_to(:define)
    end

    it 'should allow access to the api when defining a sprite with a symbol' do
      Sprites.application.define do
        sprite :foo do
          
        end
      end
      Sprites.sprites[:foo].should be_a(Sprite)
      Sprites.sprites[:foo].name.should be(:foo)
      Sprites.sprites[:foo].path.to_s.should == "sprites/foo.png"
      Sprites.sprites[:foo].stylesheet_path.should == "sprites/foo.css"
    end

    it 'should allow access to the api when defining a sprite with a hash' do
      Sprites.application.define do
        sprite 'sprites/foo.png' => 'sprites/foo.css' do
          
        end
      end

      Sprites.sprites[:foo].should be_a(Sprite)
      Sprites.sprites[:foo].name.should be(:foo)
      Sprites.sprites[:foo].path.to_s.should == "sprites/foo.png"
      Sprites.sprites[:foo].stylesheet_path.should == "sprites/foo.css"
    end


    it 'should allow access to the api when defining a sprite with a hash' do
      Sprites.application.define do
        sprite 'sprites/foo.png' do
          
        end
      end

      Sprites.sprites[:foo].should be_a(Sprite)
      Sprites.sprites[:foo].name.should be(:foo)
      Sprites.sprites[:foo].path.to_s.should == "sprites/foo.png"
      Sprites.sprites[:foo].stylesheet_path.should == "sprites/foo.css"
    end
    
  end

  context "#sprite" do
    
  end
end
