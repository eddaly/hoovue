require 'spec_helper'

describe "ProductGenres" do
  describe "GET /product_genres" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get product_genres_path
      response.status.should be(200)
    end
  end
end
