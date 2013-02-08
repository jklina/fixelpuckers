require "spec_helper"

describe ReviewsController do
  describe "routing" do

    # it "routes to #edit" do
    #   get("/reviews/1/edit").should route_to("reviews#edit", :id => "1")
    # end

    it "routes to #create" do
      post("/submissions/1/reviews").should route_to("reviews#create", submission_id: '1')
    end

    # it "routes to #update" do
    #   put("/reviews/1").should route_to("reviews#update", :id => "1")
    # end

    # it "routes to #destroy" do
    #   delete("/reviews/1").should route_to("reviews#destroy", :id => "1")
    # end

  end
end
