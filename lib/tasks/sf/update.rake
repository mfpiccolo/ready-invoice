namespace :sf do
  task update: :environment do
    User.all.each do |user|
      # Create a salesforce client here.
      # Requires users salesforce login information i.e. username and pass
      dbdc_client = Client.create({ wrapper: :databasedotcom, sf_credentials: user.sf_credentials })
      bulk_client = Client.create({ wrapper: :salesforce_bulk, sf_credentials: user.sf_credentials })

      data = []

      # users salesforce model
      salesforce = user.salesforce

      # sf_api model names as strings in array
      sf_models = user.model_names

      sf_models.each do |model|

        records = []

        dbdc_client.materialize model
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

      records_to_update = Array.new

      invoices.each do |invoice|
        updated_account = Hash["Id" => invoice.Id, "PDF_Link__c" => invoice.link] # Nearly identical to an insert, but we need to pass the salesforce id.
        records_to_update.push(updated_account)


        # sf_invoice = sf_invoice_constant.find(invoice.Id)
        # sf_invoice.update_attributes("PDF_Link__c" => invoice.link)
      end
      bulk_client.update(user.invoice_api_name, records_to_update)
    end
  end
end
