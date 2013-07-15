module RubyDesignTools
  class Builder
    def initialize
      @mock = {}
    end

    def result(cached=false)
      return @cached_result if @cached_result && cached

      instance = self.class.build_class.new
      @mock.each do |method, value|
        instance.__send__("#{method}=", value)
      end
      @cached_result = instance
    end

    def attrs=(hash)
      hash.each do |mapping, value|
        __send__("#{mapping}=", value)
      end
    end

    class << self
      attr_accessor :build_class

      def for(klass, &block)
        builder = Class.new(self)
        builder.build_class = klass
        instance_eval &block if block
        builder
      end

      def map(builder_method, target_method=builder_method)
        class_eval %Q{
          def #{builder_method}=(value)
            @mock['#{target_method}'] = value
          end

          def #{builder_method}
            @mock['#{target_method}']
          end
        }
      end
    end
  end
end
