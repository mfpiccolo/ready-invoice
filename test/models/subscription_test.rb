require "test_helper"

describe Subscription do
  before do
    @subscription = Subscription.new
  end

  it "must be valid" do
    @subscription.valid?.must_equal true
  end
end
