module RubyDesignTools
  class Decorator < BasicObject
    attr_reader :subject

    def initialize(subject)
      @subject = subject
    end

    def method_missing(method_name, *args, &block)
      @subject.__send__(method_name, *args, &block)
    end

    class << self
      def redirect(*methods)
        methods.each do |method|
          class_eval %Q{
            def #{method}(*args, &block)
              @subject.__send__(:#{method}, *args, &block)
            end
          }
        end
      end

      def accessor(*methods)
        methods.each do |method|
          class_eval %Q{
            def #{method}
              @subject.#{method}
            end
          }
        end
      end
    end
  end
end
