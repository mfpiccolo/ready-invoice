require 'test_helper'

describe FindInvoice do
  describe "#call" do
    describe "with user and invoice_oid passed" do
      before do
        @user = FactoryGirl.create(:user, uid: "123")
        @invoice = @user.plies.create
      end

      it "should return the ply instance" do
        FindInvoice.(@invoice.oid, @user).must_equal @invoice
      end
    end
  end
end
