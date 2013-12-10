class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user?, :except => [:index]

  def index
    @users = User.all
  end

    def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user
    else
      render :edit
    end
  end


  def show
    @user = User.find(params[:id])
  end


  private

  def user_params
    params.require(:user).permit(:provider, :uid, :name, :email, :role_ids, model_names: [])
  end
end
