require 'spec_helper'

describe "product_genres/show" do
  before(:each) do
    @product_genre = assign(:product_genre, stub_model(ProductGenre,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
