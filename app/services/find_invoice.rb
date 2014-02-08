class FindInvoice
  include SoftService

  collaborators :invoice_oid, :user_id

  def call
    Invoice.where(user_id: user_id, oid: invoice_oid).first
    # user.invoices.find_by_oid(invoice_oid)
  end

end
