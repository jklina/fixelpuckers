require 'reviews'

describe Pf::Reviews do
  describe ".average_rating" do
    context "when there are ratings" do
      it "returns an average rounded to two sig figs" do
        reviews = [stub(rating: 10), stub(rating: 5), stub(rating:5)]
        expect(Pf::Reviews.calc_average_rating(reviews)).to eq(6.67)
      end
    end

    context "when some reviews have ratings" do
      it "returns an average rounded to two sig figs" do
        reviews = [stub(rating: nil), stub(rating: 5), stub(rating: 15)]
        expect(Pf::Reviews.calc_average_rating(reviews)).to eq(10)
      end
    end

    context "when there are no ratings" do
      it "should return nil" do
        reviews = [stub(rating: nil), stub(rating: nil)]
        expect(Pf::Reviews.calc_average_rating(reviews)).to eq(nil)
      end
    end
  end
end
