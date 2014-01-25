class FindInvoice
  include SoftService

  collaborators :invoice_oid, :user

  def call(&block)
    Invoice.where(user_id: user.id, oid: invoice_oid).first
    # user.invoices.find_by_oid(invoice_oid)
  end

end
