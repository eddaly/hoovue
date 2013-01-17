require 'spec_helper'

describe "credit_validations/new" do
  before(:each) do
    assign(:credit_validation, stub_model(CreditValidation,
      :credit_id => "MyString",
      :user_id => "MyString",
      :user_validation => false
    ).as_new_record)
  end

  it "renders new credit_validation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => credit_validations_path, :method => "post" do
      assert_select "input#credit_validation_credit_id", :name => "credit_validation[credit_id]"
      assert_select "input#credit_validation_user_id", :name => "credit_validation[user_id]"
      assert_select "input#credit_validation_user_validation", :name => "credit_validation[user_validation]"
    end
  end
end
