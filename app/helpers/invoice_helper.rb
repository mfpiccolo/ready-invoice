module InvoiceHelper

  def layout_value(id, position)
    li = LineItem.find(id)

    if li.otype == current_user.layout.send("li_#{position}_model")
      li.send(current_user.layout.send("li_#{position}_attribute"))
    else
      model = li.children.where(otype: current_user.layout.send("li_#{position}_model")).first
      model.send(current_user.layout.send("li_#{position}_attribute"))
    end
  end

end
