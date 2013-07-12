require 'test_helper'

require 'fixtures/proxy'

describe RubyDesignTools::Proxy do
  let(:proxy)   { RubyDesignTools::Proxy.new(5) }

  it 'has the same class as the proxied object' do
    proxy.class.must_equal Fixnum
  end

  it 'has the same object id than the proxied object' do
    proxy.object_id.must_equal proxy.subject.object_id
  end

  describe 'a child of RubyDesignTools::Proxy' do
    let(:proxy) { FloatProxy.new(5.123) }

    it 'responds to methods defined in the proxy' do
      proxy.pp.must_equal '5.12'
    end
  end
end
