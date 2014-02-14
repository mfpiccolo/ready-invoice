require "test_helper"

describe "the signin process Integration", :type => :feature do
  before :each do
    FactoryGirl.create(:user)
  end
  describe "with valid user credentials", :vcr do
    it "signs a user in" do
      register_user(@user)
      assert_page_has_content page, 'Signed in!'
    end
  end
end
