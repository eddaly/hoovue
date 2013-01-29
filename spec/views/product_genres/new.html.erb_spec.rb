require 'spec_helper'

describe "product_genres/new" do
  before(:each) do
    assign(:product_genre, stub_model(ProductGenre,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new product_genre form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => product_genres_path, :method => "post" do
      assert_select "input#product_genre_name", :name => "product_genre[name]"
    end
  end
end
