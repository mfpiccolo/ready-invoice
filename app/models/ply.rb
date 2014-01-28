class Ply < Pliable::Ply
  belongs_to :user

  def link
    # TODO make this check env for host
    "https://ready-invoice.herokuapp.com/invoices/#{self.oid}"
  end

end
