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
      # TODO Needs to pass in user sf credentials.  See update.rake
      client = Client.create(wrapper: :metaforce)
      client.create(:custom_field, fullName: "#{@user.invoice_api_name}.PDF_Link__c", type: "Url", label: "PDF Link").on_complete { |job| puts "Link field created." }.perform
    else
      render :edit
    end
  end


  def show
    @user = User.find(params[:id])
  end


  private

  def user_params
    params.require(:user).permit(:provider, :uid, :name, :email, :role_ids, :username, :password, :security_token, model_names: [])
  end
end
