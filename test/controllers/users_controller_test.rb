require "test_helper"

describe UsersController do
  before do
    user = FactoryGirl.create(:user)
    UsersController.any_instance.stubs(:authenticate_user!).returns(true)
  end

  describe "GET index" do
    before { get :index }
    it {
      assert_response :success
      assert_not_nil assigns[:users]
    }
  end
end
