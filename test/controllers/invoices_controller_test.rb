require "test_helper"

describe InvoicesController do

  describe "GET index" do
    before do
      user = FactoryGirl.create(
        :user,
        uid: "123",
        invoice_api_name: "Invoice__c",
        line_item_api_name: "Line_Item__c",
        other_model_names: ["Merchandise__c"]
      )
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
      @controller.expects(:render).at_least_once
      user = FactoryGirl.create(:user)
      InvoicesController.any_instance.expects(:current_user).at_least_once.returns(user)
      invoice = user.invoices.create(oid: 12345, otype: "Invoice__c")
      line_items = mock
      line_items.stubs(:where)
      line_items.stubs(each: nil)
      RightClickAttrs.stubs(:call)
      Invoice.any_instance.stubs(line_items: line_items, Name: nil)
      get :show, id: invoice.to_param
    end

    it {
      assert_response :success
    }
  end
end
