require "test_helper"

describe Ply do
  before do
    @ply = Ply.new(oid: "fake_id")
  end

  describe "#link" do
    it "must be valid" do
      @ply.link.must_equal "https://ready-invoice.herokuapp.com/invoices/fake_id"
    end
  end
end
