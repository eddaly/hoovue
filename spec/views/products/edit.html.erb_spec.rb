require 'spec_helper'

describe "products/edit" do
  before(:each) do
    @product = assign(:product, stub_model(Product,
      :title => "MyString",
      :genre => "MyString",
      :user_id => 1,
      :image => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit product form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => products_path(@product), :method => "post" do
      assert_select "input#product_title", :name => "product[title]"
      assert_select "input#product_genre", :name => "product[genre]"
      assert_select "input#product_user_id", :name => "product[user_id]"
      assert_select "input#product_image", :name => "product[image]"
      assert_select "textarea#product_description", :name => "product[description]"
    end
  end
end
