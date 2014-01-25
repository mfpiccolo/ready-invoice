class Client
  def self.create(user, client, env=Rails.env)
    credentials = user.sf_credentials

    case client
    when :databasedotcom
      credentials[:password] = (credentials[:password] + credentials[:security_token])
      Databasedotcom::Client.new(sobject_module: "DBDC").tap do |client|
        client.authenticate credentials.delete_if { |k,v| ![:username, :password].include?(k) }
      end
    # when :restforce
    #   Restforce.new username: credentials[:username],
    #     password:        credentials[:password],
    #     security_token:  credentials[:security_token],
    #     client_id:       cfg["client_id"],
    #     client_secret:   cfg["client_secret"]
    when :metaforce
      Metaforce.new username: credentials[:username],
        password: credentials[:password],
        security_token: credentials[:security_token]
    when :salesforce_bulk
      SalesforceBulk::Api.new(credentials[:username], (credentials[:password] + credentials[:security_token]))
    end
  end
end
