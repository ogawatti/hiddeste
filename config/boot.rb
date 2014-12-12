require 'rubygems'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# developmentのdefault portを3456番にする
require 'rails/commands/server'
module Rails
  class Server
    def default_options
      super.merge( { :Port => 3456 } )
    end
  end
end
