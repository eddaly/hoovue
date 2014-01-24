require 'spec_helper'

describe "emails/new" do
  before(:each) do
    assign(:email, stub_model(Email,
      :email => "MyString",
      :user_id => 1
    ).as_new_record)
  end

  it "renders new email form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", emails_path, "post" do
      assert_select "input#email_email[name=?]", "email[email]"
      assert_select "input#email_user_id[name=?]", "email[user_id]"
    end
  end
end
