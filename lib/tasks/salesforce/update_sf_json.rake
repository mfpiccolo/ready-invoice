namespace :salesforce do
  task update_sf_json: :environment do
    User.all.each do |user|
      # Create a salesforce client here.
      # Requires users salesforce login information i.e. username and pass
      client = Client.create

      data = []

      # users salesforce model
      salesforce = user.salesforce

      # sf_api model names as strings in array
      sf_models = salesforce.models

      sf_models.each do |model|

        records = []

        client.materialize model
        "SF::#{model}".constantize.all.each do |record|
          records << record.attributes
        end

        data << { model => records }
      end

      salesforce.update_attributes(data: { "sf_collections" => data })
    end
  end
end
