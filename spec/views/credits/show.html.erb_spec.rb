require 'spec_helper'

describe "credits/show" do
  before(:each) do
    @credit = assign(:credit, stub_model(Credit,
      :user_id => 1,
      :product_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
