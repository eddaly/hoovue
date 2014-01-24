require 'spec_helper'

describe "credit_validations/index" do
  before(:each) do
    assign(:credit_validations, [
      stub_model(CreditValidation,
        :credit_id => "Credit",
        :user_id => "User",
        :user_validation => false
      ),
      stub_model(CreditValidation,
        :credit_id => "Credit",
        :user_id => "User",
        :user_validation => false
      )
    ])
  end

  it "renders a list of credit_validations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Credit".to_s, :count => 2
    assert_select "tr>td", :text => "User".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
