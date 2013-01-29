require "spec_helper"

describe ProductGenresController do
  describe "routing" do

    it "routes to #index" do
      get("/product_genres").should route_to("product_genres#index")
    end

    it "routes to #new" do
      get("/product_genres/new").should route_to("product_genres#new")
    end

    it "routes to #show" do
      get("/product_genres/1").should route_to("product_genres#show", :id => "1")
    end

    it "routes to #edit" do
      get("/product_genres/1/edit").should route_to("product_genres#edit", :id => "1")
    end

    it "routes to #create" do
      post("/product_genres").should route_to("product_genres#create")
    end

    it "routes to #update" do
      put("/product_genres/1").should route_to("product_genres#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/product_genres/1").should route_to("product_genres#destroy", :id => "1")
    end

  end
end
