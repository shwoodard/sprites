# Sprites

Sprites is a library that let's you define the sprites for your application with configuration or convention.  Sprites will generate your sprites, and a corresponding stylesheet for each using either the cli or from within a Rails application.

## The DSL for sprites.rb

``` ruby
sprite :bas

sprite :buttons, :path => "buttons.png", :stylesheet_path => "buttons.css", :autoload => false do
  sprite_piece 'buttons/btn-black-default-28.png', 'a.black.button > span, button.black.submit span'
  sprite_piece 'buttons/btn-black-default-cap-28.png', 'a.black.button, button.black.submit', :x => 'right'
  ...
end
```

## For the cli

### Project Structure

    |
    |\_config
    |   \_sprites.rb
     \_public
        \_images
          \_sprite_images
            |\_sprite_name1
            | |\_blue_icon.png
            |  \_green_icon.png
             \_sprite_name2
               |\_blue_icon.png
                \_green_icon.png

    gem install sprites

execute:

    cd PROJECT_ROOT
    sprites

For usage

    sprites --help


## In your Rails app

#### Gemfile

``` ruby
gem 'sprites'
```

#### application.rb

``` ruby
config.uses_sprites = true
```

Optionally include a `config/sprites.rb` (see above).  Otherwise _Sprites_ will use it's auto-load feature.  Example, if you have `app/assets/images/sprite_images/foo/bar.png` and `app/assets/images/sprite_images/foo/bas.png`, _Sprites_ will create `app/assets/stylesheets/sprites/foo.css` and `app/assets/images/sprites/foo.png`.  The class for `bar.png` will be `.bar` and for `bas.png`, `.bas`, etc.


    rake sprites

to generate.

## In your Rails Engine

#### engine.rb

``` ruby
module MyGem
  class Engine < Rails::Engine
    config.uses_sprites = true
  end
end
```

Use `app/assets` in your gem like you would your rails app and use the asset pipeline.

From your rails root

    ENGINES=true rake sprites

Note: this will generate your sprites for your _Sprites_ enabled Engines _and_ your _Sprites_ enabled Rails app.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
