class Ply < Pliable::Ply

  def link
    # TODO make this check env for host
    "https://localhost:3001/invoices/#{self.oid}"
  end

end
