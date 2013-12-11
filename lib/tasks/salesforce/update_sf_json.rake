namespace :salesforce do
  task update_sf_json: :environment do
    User.all.each do |user|
      # Create a salesforce client here.
      # Requires users salesforce login information i.e. username and pass
      client = Client.create
      client = Client.create(client: :databasedotcom)

      data = []

      # users salesforce model
      salesforce = user.salesforce

      # sf_api model names as strings in array
      sf_models = user.model_names

      sf_models.each do |model|

        records = []

        client.materialize model
        "SF::#{model}".constantize.all.each do |record|
          records << record.attributes
        end

        data << { model => records }
      end

      salesforce.update_attributes(data: { "sf_collections" => data } )

      salesforce.data["sf_collections"].each do |hash|
        hash.each_pair do |model, data|
          sf_model = salesforce.sf_models.find_or_initialize_by(model_name: model)
          sf_model.records = { model => data }
          sf_model.save
        end
      end

      # update the link by records
      user.reload
      invoices = user.salesforce.sf_models.first.all
      sf_invoice_constant = "SF::#{user.invoice_api_name}".constantize

      invoices.each do |invoice|
        sf_invoice = sf_invoice_constant.find(invoice.Id)
        sf_invoice.update_attributes("PDF_Link__c" => invoice.link)
      end
    end
  end
end
