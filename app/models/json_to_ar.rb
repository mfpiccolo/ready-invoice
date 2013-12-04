class JsonToAR
  attr_accessor :json

  #replaced with dynamic initialization below
  #attr_accessor :id, :user, :state
  #
  # Sample JSON
  #
  # { "id":1, "user":"john", "state":"active" }


  def initialize(json)
    @json = json
  end

  # def self.all
  #   json.map { |i| convert(i) }
  # end

  # def self.find( param )
  #   all.detect { |i| i.id == param } || raise(ActiveRecord::RecordNotFound)
  # end

  # def self.where( query )
  #   ret = []
  #   all.each { |i| ret.push(i) if i.include?(query) } ||
  #       raise(ActiveRecord::RecordNotFound)
  #   return ret
  # end

  def convert item
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
