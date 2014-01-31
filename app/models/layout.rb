class Layout < ActiveRecord::Base
  belongs_to :user

  def update_from_right_click(info)
    info = info.split("-")
    destination = info[0]
    model_name = info[1]
    attribute = info[2]
    send((destination + "_model=").to_sym, model_name)
    send((destination + "_attribute=").to_sym, attribute)
    save
  end
end
