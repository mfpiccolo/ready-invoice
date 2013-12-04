class Client
  def self.create(env=Rails.env)
    cfg = YAML.load_file(Rails.root.join("config/databasedotcom.yml"))[env]
    Databasedotcom::Client.new(cfg).tap do |client|
      client.authenticate cfg.delete_if { |k,v| ![:username, :password].include?(k) }
    end
  end
end
