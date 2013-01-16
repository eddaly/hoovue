require 'spec_helper'

describe "credits/new" do
  before(:each) do
    assign(:credit, stub_model(Credit,
      :user_id => 1,
      :product_id => 1
    ).as_new_record)
  end

  it "renders new credit form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => credits_path, :method => "post" do
      assert_select "input#credit_user_id", :name => "credit[user_id]"
      assert_select "input#credit_product_id", :name => "credit[product_id]"
    end
  end
end
