module InvoiceHelper

  def layout_value(id, position, user_id)
    li = LineItem.find(id)
    user = User.find(user_id)

    if li.otype == user.layout.try("li_#{position}_model".to_sym)
      li.send(user.layout.send("li_#{position}_attribute"))
    else
      model = li.children.where(otype: user.layout.try("li_#{position}_model".to_sym)).first
      if model.try(:send, user.layout.try("li_#{position}_attribute".to_sym)).present?
         model.send(user.layout.send("li_#{position}_attribute"))
      else
        ""
      end
    end
  end

end
