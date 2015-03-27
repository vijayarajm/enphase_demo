$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'enphase'
require 'simplecov'

SimpleCov.start do 
  add_group "lib", "lib"
end
