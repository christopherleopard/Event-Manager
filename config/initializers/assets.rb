# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"
Rails.application.config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
Rails.application.config.assets.precompile += %w( *.svg *.eot *.woff *.ttf *.woff2 )

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
