require 'spec_helper'

describe "products/show" do
  before(:each) do
    @product = assign(:product, stub_model(Product,
      :title => "Title",
      :genre => "Genre",
      :user_id => 1,
      :image => "Image",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Genre/)
    rendered.should match(/1/)
    rendered.should match(/Image/)
    rendered.should match(/MyText/)
  end
end
