require 'bundler/setup'
Bundler.require(:default)
Dir.glob('./lib/*') {|file| require file}
