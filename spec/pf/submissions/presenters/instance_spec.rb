require 'action_view/helpers/tag_helper'
require 'submissions/presenters/instance'

include ActionView::Helpers::TagHelper
include ActionView::Context

describe Pf::Submissions::Presenters::Instance do
  describe "#featured_at" do
    context "when a featured_at date is present" do
      it "displays the date in the correct html" do
        submission = stub(featured_at: Date.today)
        presenter = Pf::Submissions::Presenters::Instance.for(submission)
        formatted_date = content_tag :li do
          content_tag(:i, class: "ss-icon")
          "Featured: #{submission.featured_at}"
        end
        expect(presenter.featured_at).to eq(formatted_date)
      end
    end


    context "when a featured_at date isn't present" do
      it "returns nil" do
        submission = stub(featured_at: nil)
        presenter = Pf::Submissions::Presenters::Instance.for(submission)
        expect(presenter.featured_at).to eq(nil)
      end
    end
  end

  describe "#average_rating" do
    context "when there are ratings" do
      it "displays the average rating" do
        average_rating = rand(0..100)
        submission = stub(average_rating: average_rating)
        presenter = Pf::Submissions::Presenters::Instance.for(submission)
        expect(presenter.average_rating).to eq("User Rating: #{average_rating}")
      end
    end

    context "when there are no ratings" do
      it "displays a message that there are no ratings" do
        submission = stub(average_rating: nil)
        presenter = Pf::Submissions::Presenters::Instance.for(submission)
        expect(presenter.average_rating).to eq("User Rating: None")
      end
    end
  end

  describe "#downloads" do
    it "displays the number of downloads" do
      downloads = rand(0..100)
      submission = stub(downloads: downloads)
      presenter = Pf::Submissions::Presenters::Instance.for(submission)
      expect(presenter.downloads).to eq("#{downloads} Downloads")
    end
  end

  describe "#views" do
    it "displays the number of views" do
      views = rand(0..100)
      submission = stub(views: views)
      presenter = Pf::Submissions::Presenters::Instance.for(submission)
      expect(presenter.views).to eq("#{views} Views")
    end
  end

  describe "#number_of_reviews" do
    it "displays the number of reviews" do
      reviews_count = rand(0..100)
      submission = stub()
      submission.stub_chain(:reviews, :count).and_return(reviews_count)
      presenter = Pf::Submissions::Presenters::Instance.for(submission)
      expect(presenter.number_of_reviews).to eq("#{reviews_count} Reviews")
    end
  end

  describe "presenter's inheritance" do
    it "forwards undefined methods in the presenter to the source object" do
      submission = stub(ohhai: "oh hai")
      presenter = Pf::Submissions::Presenters::Instance.for(submission)
      expect(presenter.ohhai).to eq(submission.ohhai)
    end
  end
end
