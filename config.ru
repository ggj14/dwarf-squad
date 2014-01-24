# get middleman working with Pow (ref: https://github.com/middleman/middleman/pull/560)

require 'rubygems'
require 'bundler'
Bundler.setup
require 'middleman'
require 'middleman-core/preview_server'

module Middleman::PreviewServer
  def self.preview_in_rack
    @options = { latency: 0.25 }
    @app = new_app
    start_file_watcher
  end
end

Middleman::PreviewServer.preview_in_rack
run Middleman::PreviewServer.app.class.to_rack_app
