class RightClickAttrs
  include SoftService

  collaborators :user_id, :invoice_id

  def call
    user = User.find(user_id)
    invoice = user.invoices.where(id: invoice_id).first
    line_item = invoice.send(user.line_item_scope).first
    merchandise = line_item.send(user.other_model_names_scope).first
    {
      "invoice_fold" =>
        { "items" =>
          data_to_name_hash(invoice),
          "name" =>
            user.invoice_api_name
        },
      "line_item_fold" =>
        { "items" =>
          data_to_name_hash(line_item),
          "name" =>
            line_item.otype
        },
      "merchandise_fold" =>
        { "items" =>
          data_to_name_hash(merchandise),
          "name" =>
          merchandise.otype
        }
    }.to_json
  end

  def data_to_name_hash(model)
    names = {}
    model.data.keys.each_with_index do |attribute, i|
      names.merge!({ "#{model.otype}-#{attribute}" => { "name" => attribute } })
    end
    names
  end

end
