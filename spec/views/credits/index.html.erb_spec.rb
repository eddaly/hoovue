require 'spec_helper'

describe "credits/index" do
  before(:each) do
    assign(:credits, [
      stub_model(Credit,
        :user_id => 1,
        :product_id => 2
      ),
      stub_model(Credit,
        :user_id => 1,
        :product_id => 2
      )
    ])
  end

  it "renders a list of credits" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
