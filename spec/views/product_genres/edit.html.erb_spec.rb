require 'spec_helper'

describe "product_genres/edit" do
  before(:each) do
    @product_genre = assign(:product_genre, stub_model(ProductGenre,
      :name => "MyString"
    ))
  end

  it "renders the edit product_genre form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => product_genres_path(@product_genre), :method => "post" do
      assert_select "input#product_genre_name", :name => "product_genre[name]"
    end
  end
end
