class FindInvoice
  include SoftService

  collaborators :invoice_oid, :user

  def call(&block)
    user.sf_objects.find_by_oid(invoice_oid)
  end

end
