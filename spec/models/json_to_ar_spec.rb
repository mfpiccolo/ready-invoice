require "spec_helper"

describe JsonToAR do
  before do
    @record = JsonToAR.new("Some Item")
  end

  describe "#include?" do
    describe "with invalid parameters" do
      it "should raise error" do
        @record.include("some query").should_raise InvalidParamType
      end
    end

    describe "with valid parameters" do
      describe "when the record has the instance varaible set form the query" do

      end

      describe "whent he record does not have the instance variable set from the query" do

      end
    end
  end

  describe "#link" do
    it "should return the link to show the record" do
      @record.link.should eq "https://localhost:3001/invoices/#{self.to_param}"
    end
  end
end
