require 'test_helper'

require 'fixtures/decorator'

describe RubyDesignTools::Decorator do
  let(:decorator)   { RubyDesignTools::Decorator.new(5) }

  it 'has the same class as the proxied object' do
    decorator.class.must_equal Fixnum
  end

  it 'has the same object id than the proxied object' do
    decorator.object_id.must_equal decorator.subject.object_id
  end

  describe 'a child of RubyDesignTools::Decorator' do
    let(:decorator) { FloatDecorator.new(5.123) }

    it 'responds to methods defined in the decorator' do
      decorator.pp.must_equal '5.12'
    end
  end
end
