class PliesController < ApplicationController

  def update_all
    SfSynch.(current_user)
    redirect_to "/"
  end
end
