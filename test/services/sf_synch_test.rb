require 'test_helper'
include Capybara::DSL
include SignInHelper

describe SfSynch, :vcr do
  before do
    @user = FactoryGirl.create(:user)
    # register_user(@user)
  end

  describe "#call" do
    it "should call the the methods" do
      SfSynch.any_instance.expects(:set_clients)
      SfSynch.any_instance.expects(:update_pg_from_sf)
      SfSynch.any_instance.expects(:synch_pdf_link_to_sf)
      SfSynch.any_instance.expects(:create_relations)
      SfSynch.(@user)
    end
  end

  describe "methods" do
    before do
      @synch = SfSynch.new(@user)
      @synch.call
    end

    describe "#set_clients" do
      it {
        @synch.dbdc_client.user_id.must_equal "005i0000002glV1AAI"
        @synch.bulk_client.must_respond_to(:upsert)
      }
    end

    describe "#update_pg_from_sf" do
      before do
        # Mimics what ply gem would do with a current_user
        Invoice.send(:ply_name, "Invoice__c")
        LineItem.send(:ply_name, "Line_Item__c")
        Merchandise.send(:ply_name, "Merchandise__c")
        @synch.update_pg_from_sf
      end
      it "sets the dbdc constants and creates pg records" do
        assert DBDC.const_defined?("Invoice__c")
        assert DBDC.const_defined?("Line_Item__c")
        assert DBDC.const_defined?("Merchandise__c")
        Invoice.count.must_equal 3
        LineItem.count.must_equal 4
        Merchandise.count.must_equal 4
      end
    end

    describe "#synch_pdf_link_to_sf" do
      before do
        @synch.synch_pdf_link_to_sf
      end

      it "should set the PDF link on the salesforce object" do
        DBDC::Invoice__c.all.first.must_respond_to(:PDF_Link__c)
      end
    end

    describe "#create_relations" do

      it "creates realationships between the imported models" do
        invoice = Invoice.first
        line_item = invoice.line_items.first
        invoice.line_items.count.must_equal 1
        line_item.invoices.count.must_equal 1
      end
    end
  end
end
