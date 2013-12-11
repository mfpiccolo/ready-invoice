class Client
  def self.create(opts={}, env=Rails.env)
    case opts[:client]
    when :databasedotcom
      cfg = YAML.load_file(Rails.root.join("config/databasedotcom.yml"))[env]
      Databasedotcom::Client.new(cfg).tap do |client|
        client.authenticate cfg.delete_if { |k,v| ![:username, :password].include?(k) }
      end
    when :restforce
      cfg = YAML.load_file(Rails.root.join("config/restforce.yml"))[env]
      Metaforce.new username: cfg["username"],
        password:        cfg["password"],
        security_token:  cfg["security_token"],
        client_id:       cfg["client_id"],
        client_secret:   cfg["client_secret"]
    when :metaforce
      cfg = YAML.load_file(Rails.root.join("config/metaforce.yml"))[env]
      Metaforce.new username: cfg["username"],
        password: cfg["password"],
        security_token: cfg["security_token"]
    when :bulk_api
      cfg = YAML.load_file(Rails.root.join("config/bulk_api.yml"))[env]
      SalesforceBulkApi::Api.new({
        client_id: cfg["client_id"],
        client_secret: cfg["client_secret"],
        host: cfg["host_name"],
        username: cfg["username"],
        password: ["password"]
      })
    end
  end
end
