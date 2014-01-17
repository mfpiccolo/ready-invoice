require "test_helper"

describe Ply do
  before do
    @ply = Ply.new
  end

  it "must be valid" do
    @ply.valid?.must_equal true
  end
end
