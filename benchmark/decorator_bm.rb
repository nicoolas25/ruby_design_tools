require 'benchmark_helper'

class Subject
  def initialize
    @count = 0
  end

  def method
    @count += 1
  end
end

n         = ENV['N'] || 5000000
subject   = Subject.new
decorated = RubyDesignTools::Decorator.new(Subject.new)


Benchmark.bmbm do |b|
  b.report('direct')    { n.times { subject.method } }
  b.report('decorated') { n.times { decorated.method } }
end
