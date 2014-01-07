class SfSynch
  include SoftService

  attr_reader :dbdc_client, :bulk_client

  collaborators :user

  def call(&block)
    set_clients
    update_pg_from_sf
    synch_pdf_link_to_sf
    create_relations
    block ? block.call(self) : self
  end

  def set_clients
    # Create a salesforce client here.
    # Requires users salesforce login information i.e. username and pass
    @dbdc_client = Client.create(user, :databasedotcom)
    @bulk_client = Client.create(user, :salesforce_bulk)
  end

  def update_pg_from_sf
    data = []

    # sf_api model names as strings in array
    user.model_names.each do |model|

      records = []

      dbdc_client.materialize model
      "DBDC::#{model}".constantize.all.each do |record|
        # if record.LastModifiedDate.to_date > Date.today.advance(days: -1)
          object = user.sf_objects.find_or_create_by(oid: record.Id)
          object.update_attributes(
            data: record.attributes,
            otype: model,
            last_checked: Time.zone.now,
            last_modified: Time.zone.now
          )
        # end
      end
    end
  end

  def synch_pdf_link_to_sf
    # update the link by records
    user.reload
    invoices = user.sf_objects

    records_to_update = Array.new

    invoices.each do |invoice|
      updated_account = Hash["Id" => invoice.oid, "PDF_Link__c" => invoice.link]
      records_to_update.push(updated_account)
    end
    bulk_client.update(user.invoice_api_name, records_to_update)
  end

  def create_relations
    user.sf_objects.each do |record|
      related_model_names = record.instance_variables.map {|e| e.to_s.gsub("@", "") } & user.model_names
      related_model_names.each do |name|
        child = SfObject.find_by_oid(record.send(name.to_sym))
        unless SfObjectRelation.where(parent_id: record.id, child_id: child.id).present?
          SfObjectRelation.create!(
            parent_id: record.id,
            parent_type: record.otype,
            child_id: child.id,
            child_type: child.otype
            )
        end
      end
    end
  end

  def self.update_if_needed_for(user)
    if user.sf_objects.oldest_last_checked_time > Time.now.advance(hours: 1)
      call
    end
  end
end
