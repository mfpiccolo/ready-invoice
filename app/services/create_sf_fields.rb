class CreateSfFields
  include SoftService

  attr_reader :client

  collaborators :user

  def call(&block)
    create_client
    create_sf_field
  end

  def create_client
    @client = Client.create(user, :metaforce)
  end

  def create_sf_field
    client.create(
      :custom_field,
      fullName: "#{@user.invoice_api_name}.PDF_Link__c",
      type: "Url",
      label: "PDF Link"
    ).on_complete { |job| puts "Link field created." }.perform
  end

end

