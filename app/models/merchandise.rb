class Merchandise < Ply

  ply_name User.current_user.try(:other_model_names).try(:first)

end
