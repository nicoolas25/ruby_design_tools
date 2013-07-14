require 'benchmark_helper'

class Subject
  def initialize
    @count = 0
  end

  def method
    @count += 1
  end
end

class SubjectDecorator < RubyDesignTools::Decorator
  def method
    subject.method
  end
end

class SubjectDecoratorRedirectDSL < RubyDesignTools::Decorator
  redirect :method
end

class SubjectDecoratorAccessorDSL < RubyDesignTools::Decorator
  accessor :method
end

n        = ENV['N'] || 5000000
subject  = Subject.new
proxied  = RubyDesignTools::Decorator.new(Subject.new)
explicit = SubjectDecorator.new(Subject.new)
redirect = SubjectDecoratorRedirectDSL.new(Subject.new)
accessor = SubjectDecoratorAccessorDSL.new(Subject.new)


Benchmark.bmbm do |b|
  b.report('direct call')          { n.times { subject.method } }
  b.report('redefinition')         { n.times { explicit.method } }
  b.report('DSL accessor')         { n.times { accessor.method } }
  b.report('DSL redirect')         { n.times { redirect.method } }
  b.report('method_missing')       { n.times { proxied.method } }
end
