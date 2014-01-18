class FindInvoice
  include SoftService

  collaborators :invoice_oid, :user

  def call(&block)
    user.invoices.find_by_oid(invoice_oid)
  end

end
