require 'spec_helper'

describe "credit_validations/show" do
  before(:each) do
    @credit_validation = assign(:credit_validation, stub_model(CreditValidation,
      :credit_id => "Credit",
      :user_id => "User",
      :user_validation => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Credit/)
    rendered.should match(/User/)
    rendered.should match(/false/)
  end
end
