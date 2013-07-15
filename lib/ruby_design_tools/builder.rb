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
        conf = Configuration.new(builder)
        block.call(conf)
        conf.mapping.each do |bm, tm|
          builder.define_mapping bm, tm
        end
        builder
      end

      def define_mapping(builder_method, target_method)
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

    class Configuration
      attr_reader :builder
      attr_reader :mapping

      def initialize(builder)
        @builder = builder
        @mapping = {}
      end

      def map(builder_method, target_method=builder_method)
        @mapping[builder_method.to_sym] = target_method.to_sym
      end
    end
  end
end

# Usage example:
#
# UserBuilder = Builder.for(User) do |config|
#   config.map :name, :username
#   config.map :email
# end
#
# b = UserBuilder.new
# b.name = 'Nicolas'
# b.email = 'nicolas@example.com'
# user_0 = b.result
#
# b = UserBuilder.new
# b.attrs = { name: 'Nicolas', email: 'nicolas@example.com' }
# user_1 = b.result
#
# user_1.username == b.name
# user_1.username == 'Nicolas'
# user_1.email == b.email
# user_1.email == 'nicolas@example.com'

