class PliesController < ApplicationController

  def update_all
    # SfSynch.(current_user)
    flash_message :notice, 'This is working!'
    redirect_to "/"
  end
end
