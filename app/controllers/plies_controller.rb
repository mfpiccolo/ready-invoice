class PliesController < ApplicationController

  def update_all
    SfSynch.(current_user)
    add_flash_message :notice, 'You have refreshed your data!'
    redirect_to "/"
  end
end
