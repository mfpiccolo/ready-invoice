require "test_helper"

describe PlyRelation do
  before do
    @ply_relation = PlyRelation.new
  end

  it "must be valid" do
    @ply_relation.valid?.must_equal true
  end
end
