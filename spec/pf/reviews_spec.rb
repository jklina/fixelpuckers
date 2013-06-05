require 'reviews'

describe Pf::Reviews do
  describe ".average_rating" do
    context "when there are ratings" do
      it "returns an average rounded to two sig figs" do
        reviews = [double(rating: 10), double(rating: 5), double(rating:5)]
        expect(Pf::Reviews.calc_average_rating(reviews)).to eq(6.67)
      end
    end

    context "when some reviews have ratings" do
      it "returns an average rounded to two sig figs" do
        reviews = [double(rating: nil), double(rating: 5), double(rating: 15)]
        expect(Pf::Reviews.calc_average_rating(reviews)).to eq(10)
      end
    end

    context "when there are no ratings" do
      it "returns nil" do
        reviews = [double(rating: nil), double(rating: nil)]
        expect(Pf::Reviews.calc_average_rating(reviews)).to eq(nil)
      end
    end
  end

  describe ".ratings" do
    it "returns an array of all the ratings in a collection of reviews" do
      reviews = []
      reviews << double(rating: 10)
      reviews << double(rating: 20)
      expect(Pf::Reviews.ratings(reviews)).to eq([10, 20])
    end
  end
end
