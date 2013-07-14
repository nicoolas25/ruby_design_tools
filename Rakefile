require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = 'test/*_test.rb'
  t.verbose = true
end

desc "Run tests"
task :default => :test

desc "Run benchmarks"
task :bench do
  current_dir = File.expand_path('..', __FILE__)
  $LOAD_PATH.unshift(current_dir) unless $LOAD_PATH.include?(current_dir)

  lib_dir = File.expand_path('../lib', __FILE__)
  $LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

  bench_dir = File.expand_path('../benchmark', __FILE__)
  $LOAD_PATH.unshift(bench_dir) unless $LOAD_PATH.include?(bench_dir)

  Dir['benchmark/*_bm.rb'].each{ |file| require file }
end
