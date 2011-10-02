require 'spec_helper'

describe Stylesheet do

  context "self.sprite_full_path(configuration, sprite)" do
    it 'should return the stylesheet full path' do
      config = Configuration.new
      config.sprite_stylesheets_path('tmp/stylesheets')

      stylesheet = Stylesheet.new('sprites/foo.css')

      Stylesheet.stylesheet_full_path(config, stylesheet).should == 'tmp/stylesheets/sprites/foo.css'
    end
  end
  
end
