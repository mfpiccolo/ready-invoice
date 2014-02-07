require "test_helper"

describe InvoicesController do

  describe "GET index" do
    before do
      user = User.create(model_names: ["Invoice__c", "Merchandise__c", "Line_Item__c"])
      InvoicesController.any_instance.stubs(:current_user).returns(user)
      get :index
    end

    it {
      assert_response :success
      assert_not_nil assigns[:invoices]
    }
  end

  describe "show" do
    before do
      user = FactoryGirl.create(:user)
      InvoicesController.any_instance.expects(:current_user).returns(user)
      invoice = user.sf_objects.create!(oid: 12345)
      line_items = mock
      line_items.stubs(each: nil)
      SfObject.any_instance.stubs(line_items: line_items, Name: nil)
      get :show, id: invoice.to_param
    end

    it {
      assert_response :success
      assert_template "invoices/pdf.html.erb"
    }
  end
end
