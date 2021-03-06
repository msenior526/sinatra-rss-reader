ENV['RACK_ENV'] ||= 'development'

require 'bundler'
require 'open-uri' #=> For RSS
require 'securerandom'

Bundler.require(:default, ENV['RACK_ENV'])

require 'sinatra/flash'
require 'rack/ssl-enforcer' if production?

configure :development do
  set :database, 'sqlite3:db/development.sqlite'
end

configure :test do
  set :database, 'sqlite3:db/test.sqlite'
end

configure :production do
  set :database, ENV['DATABASE_URL'] 
end

# Extend Simple RSS to include enclosure tag attributes
SimpleRSS.item_tags << :"enclosure#url"
SimpleRSS.item_tags << :"enclosure#type"
SimpleRSS.feed_tags << :url # Lives inside image tag of channel, points to image url


require_all 'app'