require 'spec_helper'

describe "emails/edit" do
  before(:each) do
    @email = assign(:email, stub_model(Email,
      :email => "MyString",
      :user_id => 1
    ))
  end

  it "renders the edit email form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", email_path(@email), "post" do
      assert_select "input#email_email[name=?]", "email[email]"
      assert_select "input#email_user_id[name=?]", "email[user_id]"
    end
  end
end
