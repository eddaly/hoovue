require "spec_helper"

describe CreditValidationsController do
  describe "routing" do

    it "routes to #index" do
      get("/credit_validations").should route_to("credit_validations#index")
    end

    it "routes to #new" do
      get("/credit_validations/new").should route_to("credit_validations#new")
    end

    it "routes to #show" do
      get("/credit_validations/1").should route_to("credit_validations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/credit_validations/1/edit").should route_to("credit_validations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/credit_validations").should route_to("credit_validations#create")
    end

    it "routes to #update" do
      put("/credit_validations/1").should route_to("credit_validations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/credit_validations/1").should route_to("credit_validations#destroy", :id => "1")
    end

  end
end
