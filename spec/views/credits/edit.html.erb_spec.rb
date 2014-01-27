require 'spec_helper'

describe "credits/edit" do
  before(:each) do
    @credit = assign(:credit, stub_model(Credit,
      :user_id => 1,
      :product_id => 1
    ))
  end

  it "renders the edit credit form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => credits_path(@credit), :method => "post" do
      assert_select "input#credit_user_id", :name => "credit[user_id]"
      assert_select "input#credit_product_id", :name => "credit[product_id]"
    end
  end
end
