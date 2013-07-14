module RubyDesignTools
  class Decorator < BasicObject
    attr_reader :subject

    def initialize(subject)
      @subject = subject
    end

    def method_missing(method_name, *args, &block)
      @subject.send(method_name, *args, &block)
    end
  end
end
