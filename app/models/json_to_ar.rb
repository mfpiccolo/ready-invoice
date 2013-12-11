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

  def to_param
    self.try(:Id)
  end

  def link
    # TODO make this check env for host
    "https://localhost:3001/invoices/#{self.to_param}"
  end

end
