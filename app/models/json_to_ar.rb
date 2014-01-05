class JsonToAR

  attr_reader :item, :model_name

  def initialize item, model_name
    @item = item
    @model_name = model_name

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

  def inspect
    attributes_as_nice_string = self.instance_variables.collect { |name|
      unless name.to_s == "@item" || name.to_s == "@model_name"
        "#{name.to_s}: #{self.send(name.to_s.gsub("@", "").to_sym)}"
      end
    }.compact.join(", ")
    "#<#{model_name} #{attributes_as_nice_string}>"
  end
end
