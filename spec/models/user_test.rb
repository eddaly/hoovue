require 'spec_helper'

   describe "NewUser" do
  it "Creates a New User" do
    visit new_user_path
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    fill_in "Password Confirmation", :with => user.password
    click_button "Register"   
    current_path.should eq(user_path)
    page.should have_content("Thank you for signing up")
    user_id.to.should include(user.id)
    end
  end
  
