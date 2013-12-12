class Client
  def self.create(opts={}, env=Rails.env)
    case opts[:wrapper]
    when :databasedotcom
      cfg = YAML.load_file(Rails.root.join("config/databasedotcom.yml"))[env]
      Databasedotcom::Client.new(cfg).tap do |client|
        client.authenticate cfg.delete_if { |k,v| ![:username, :password].include?(k) }
      end
    when :restforce
      cfg = YAML.load_file(Rails.root.join("config/restforce.yml"))[env]
      Metaforce.new username: opts[:sf_credentials][:username],
        password:        opts[:sf_credentials][:password],
        security_token:  opts[:sf_credentials][:security_token],
        client_id:       cfg["client_id"],
        client_secret:   cfg["client_secret"]
    when :metaforce
      cfg = YAML.load_file(Rails.root.join("config/metaforce.yml"))[env]
      Metaforce.new username: opts[:sf_credentials][:username],
        password: opts[:sf_credentials][:password],
        security_token: opts[:sf_credentials][:security_token]
    when :salesforce_bulk
      cfg = YAML.load_file(Rails.root.join("config/salesforce_bulk.yml"))[env]
      SalesforceBulk::Api.new(opts[:sf_credentials][:username], (opts[:sf_credentials][:password] + opts[:sf_credentials][:security_token]))
    end
  end
end
