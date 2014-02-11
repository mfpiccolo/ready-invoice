require "test_helper"

describe "the signin process Integration", :type => :feature do
  before :each do
    FactoryGirl.create(:user)
  end
  describe "with valid user credentials", :vcr do
    it "signs a user in", js: true do
      visit "/"
      click_link "Log In"
      fill_in "username", with: "dummyguytest@gmail.com"
      fill_in "password", with: "Dummypass1"
      click_button('Log in to Salesforce')
      assert_page_has_content page, 'Signed in!'
    end
  end
end
