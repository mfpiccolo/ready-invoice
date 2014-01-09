require "test_helper"

describe UsersController do
  before do

  end

  describe "GET new" do
    it "should get new" do
      get :index
      assert_response :success
      assert_not_nil assigns[:users]
    end
  end
end
