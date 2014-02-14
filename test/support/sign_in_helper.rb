module SignInHelper
  def register_user(user)
    visit "/"
    click_link "Log In"
    fill_in "username", with: user.username
    fill_in "password", with: user.password
    click_button('Log in to Salesforce')
    assert_page_has_content page, 'Signed in!'
  end
end
