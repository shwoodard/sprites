require 'spec_helper'

describe Sprites::Application do
  before do
    @app = Sprites::Application.new
  end

  context "#define" do
    it 'should respond to define' do
      @app.should respond_to(:define)
    end

    it 'should allow access to the api when defining a sprite with a symbol' do
      @app.sprite(:foo)

      @app.sprites[:foo].should be_a(Sprites::Sprite)
      @app.sprites[:foo].name.should be(:foo)
      @app.sprites[:foo].path.to_s.should == "foo.png"
      @app.sprites[:foo].stylesheet_path.should == "foo.css"
    end

    it 'should allow access to the api when defining a sprite with a hash' do
      @app.sprite(:foo, :path => 'sprites/foo.png', :stylesheet_path => 'sprites/foo.css')
      @app.sprites[:foo].should be_a(Sprites::Sprite)
      @app.sprites[:foo].name.should be(:foo)
      @app.sprites[:foo].path.to_s.should == "sprites/foo.png"
      @app.sprites[:foo].stylesheet_path.should == "sprites/foo.css"
    end
    
  end

  context "#sprite" do
    it 'should respond_to sprite' do
      @app.should respond_to(:sprite)
    end

    it 'should add a sprite' do
      @app.sprite(:foo) {}
      @app.sprites.should_not be_empty
      @app.sprites.count.should be(1)
      @app.sprites[:foo].should be_a(Sprites::Sprite)
    end
  end

  context 'initialize' do
    it 'should create the sprites adt' do
      @app.sprites.should_not be_nil
    end
  end
end
