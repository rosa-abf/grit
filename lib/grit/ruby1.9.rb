class String
  if self.method_defined?(:ord)
    def getord(offset); self[offset].ord; end
  else
    alias :getord :[]
  end

  unless self.method_defined?(:b)
    if self.method_defined?(:force_encoding)
      def b; self.dup.force_encoding(Encoding::ASCII_8BIT); end
    else
      def b; self.dup; end
    end
  end
end

if ((defined? RUBY_VERSION) && (RUBY_VERSION[0..2].to_f >= 1.9))
  class String
    def default_encoding!; force_encoding(Encoding.default_internal || Encoding::UTF_8); end
    def binary_encoding!; force_encoding(Encoding::BINARY); end
  end

  class Object
    def instance_variable_set(symbol, obj)
      obj.default_encoding! if self.class.to_s.start_with?('Grit::') && obj.is_a?(String)
      super
    end
  end
else
  class String
    def default_encoding!; self; end
    def binary_encoding!; self; end
  end
end
