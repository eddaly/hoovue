require 'spec_helper'

describe "product_genres/index" do
  before(:each) do
    assign(:product_genres, [
      stub_model(ProductGenre,
        :name => "Name"
      ),
      stub_model(ProductGenre,
        :name => "Name"
      )
    ])
  end

  it "renders a list of product_genres" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
