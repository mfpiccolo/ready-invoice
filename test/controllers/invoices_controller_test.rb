require "test_helper"

describe InvoicesController do

  describe "GET index" do
    before do
      user = User.create(model_names: ["Invoice__c", "Merchandise__c", "Line_Items__c"])
      InvoicesController.any_instance.stubs(:current_user).returns(user)
      get :index
    end

    it {
      assert_response :success
      assert_not_nil assigns[:invoices]
    }
  end
end
