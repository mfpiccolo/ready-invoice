module InvoiceHelper

  def layout_value(id, position, user_id)
    li = LineItem.find(id)
    user = User.find(user_id)

    if li.otype == user.layout.send("li_#{position}_model")
      li.send(user.layout.send("li_#{position}_attribute"))
    else
      model = li.children.where(otype: user.layout.send("li_#{position}_model")).first
      if model.send(user.layout.send("li_#{position}_attribute")).present?
         model.send(user.layout.send("li_#{position}_attribute"))
      else
        ""
      end
      rescue ActionView::Template::Error
        ""
    end
  end

end
