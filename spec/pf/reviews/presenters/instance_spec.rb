require 'action_view/helpers/tag_helper'
require 'reviews/presenters/instance'

include ActionView::Helpers::TagHelper
include ActionView::Context

describe Pf::Reviews::Presenters::Instance do
  it_behaves_like "a presentable instance"

  describe "#commentable_info" do
    it "returns a string that angular can parse with the type and id" do
      review = double(id: 4)
      presenter = Pf::Reviews::Presenters::Instance.for(review)
      angular_init = "{votable_id: '#{review.id}', votable_type: '#{review.class.to_s}'"
      expect(presenter.commentable_info).to eq(angular_init)
    end
  end
end
