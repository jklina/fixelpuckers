module Pf
  module Reviews
    def self.calc_average_rating(reviews)
      reviews_with_ratings = with_ratings(reviews)
      ratings_count = reviews_with_ratings.count
      if ratings_count > 0
        reviews_with_ratings = with_ratings(reviews)
        sum_of_ratings = reviews_with_ratings.inject(0) do |sum, review|
          sum + review.rating
        end.to_f
        (sum_of_ratings / ratings_count).round(2)
      else
        nil
      end
    end

    private

    def self.with_ratings(reviews)
      reviews.select { |review| !review.rating.nil? }
    end
  end
end
