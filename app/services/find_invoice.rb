class FindInvoice
  include SoftService

  collaborators :invoice_oid, :user_id

  def call(&block)
    puts "User ID: #{user_id}"
    puts "Invoice ID: #{invoice_oid}"
    Invoice.where(user_id: user_id, oid: invoice_oid).first
    # user.invoices.find_by_oid(invoice_oid)
  end

end
