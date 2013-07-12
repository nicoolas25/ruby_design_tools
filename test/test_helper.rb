require 'ruby_design_tools'
require 'minitest/autorun'

test_dir = File.expand_path('..', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(test_dir)

