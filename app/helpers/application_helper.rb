module ApplicationHelper

  def add_flash_message(key,message)
    flash[key]=message
  end

  def flash_messages
    render 'shared/flash', :messages => flash
  end

end
