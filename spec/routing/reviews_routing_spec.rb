require "spec_helper"

describe ReviewsController, type: :routing do
  describe "routing" do
    it "routes to #create" do
      expect(post("/submissions/1/reviews")).
        to route_to("reviews#create", submission_id: '1')
    end
  end
end
