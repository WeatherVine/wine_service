require 'rubygems'
require "bundler"
require 'require_all'
require 'figaro/sinatra'
Bundler.require(:default)
Bundler.require(Sinatra::Base.environment)
require "active_support/deprecation"
require "active_support/all"
require_all 'lib'
