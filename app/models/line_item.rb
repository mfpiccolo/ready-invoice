class LineItem < Ply

  ply_name User.current_user.try(:line_item_api_name)

end
