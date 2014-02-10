require 'spec_helper'

describe SubmissionsHelper do
  describe "#trash_toggle" do
    it "displays a URL to trash a submission when submission is not trashed" do
      submission = stub_model(Submission)
      expect(helper.trash_toggle(submission)).
        to eq(link_to("Trash", trash_submission_path(submission),
                      method: :patch))
    end

    it "displays the URL to untrash a trashed submission" do
      submission = stub_model(Submission, trashed?: true)
      expect(helper.trash_toggle(submission)).
        to eq(link_to("Un-Trash", trash_submission_path(submission),
                      method: :patch))

    end
  end
end
