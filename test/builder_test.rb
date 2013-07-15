require 'test_helper'

require 'fixtures/builder'

describe RubyDesignTools::Builder do
  let(:builder) { builder_class.new }
  let(:builder_class) do
    RubyDesignTools::Builder.for(A) do
      map :bar, :foo
    end
  end

  describe 'the builder class' do
    describe '#for' do
      it 'builds a builder for the given class' do
        klass = RubyDesignTools::Builder.for(A)
        klass.ancestors.must_include RubyDesignTools::Builder
      end

      it 'evals the given block in the context of the new class' do
        klass = RubyDesignTools::Builder.for(A){ def foobar; end }
        klass.must_respond_to :foobar
      end
    end

    describe '#map' do
      it 'creates a getter for its first argument' do
        builder.must_respond_to :bar
      end

      it 'creates a setter for its first argument' do
        builder.must_respond_to :bar=
      end

      it 'allow the set and retrieve a value' do
        builder.bar = 5
        builder.bar.must_equal 5
      end
    end

    describe '#build_class' do
      it 'responds with the class given to the #for method' do
        builder_class.build_class.must_equal A
      end
    end
  end

  it 'responds to the mapped methods' do
    builder.must_respond_to :bar
  end

  describe '#attrs=' do
    it 'sets the value of multiple attributes' do
      builder.bar.must_be_nil
      builder.attrs = { bar: 5 }
      builder.bar.must_equal 5
    end
  end

  describe '#result' do
    before do
      builder.bar = 5
    end

    it 'returns an instance of build_class' do
      builder.result.must_be_instance_of builder.class.build_class
    end

    describe 'this instance' do
      it 'is set with the given attributes' do
        instance = builder.result
        instance.foo.must_equal builder.bar
      end
    end
  end
end
