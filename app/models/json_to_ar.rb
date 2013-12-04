class JsonToAR

  def initialize item
    raise "expected Hash param" unless item.kind_of? Hash
    item.each do |key,value|
      instance_variable_set("@#{key.to_s}".to_sym, value)
      define_singleton_method(key.to_s) { instance_variable_get("@#{key.to_s}".to_sym) }
    end
  end

  def include? query
    raise InvalidParamType unless query.respond_to?('has_key?') and query.respond_to?('has_value?')
    query.each do |k,v|
      return false unless self.instance_variable_get("@#{k.to_s}".to_sym) == v
    end
  end

end
