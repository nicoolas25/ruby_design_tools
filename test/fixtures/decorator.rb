class FloatDecorator < RubyDesignTools::Decorator
  def pp
    '%.2f' % subject
  end
end
