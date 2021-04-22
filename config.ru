require 'bundler'
Bundler.require

$LOAD_PATH.unshift(File.expand_path("app", __dir__))

require 'app/controllers/wine_service_app'

run WineServiceApp
