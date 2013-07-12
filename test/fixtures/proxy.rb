class FloatProxy < RubyDesignTools::Proxy
  def pp
    '%.2f' % subject
  end
end
