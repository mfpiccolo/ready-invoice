class Invoice < Ply

  # If you dont put this you will get all Ply records
  ply_name User.current_user.try(:invoice_api_name)

end
