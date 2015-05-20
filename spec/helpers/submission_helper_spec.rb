require 'spec_helper'

describe SubmissionsHelper, type: :helper do
  describe "#trash_toggle" do
    it "displays a URL to trash a submission when submission is not trashed" do
      submission = double('submission', trashed?: false)
      expect(helper.trash_toggle(submission)).
        to eq(link_to("Trash", trash_submission_path(submission),
                      method: :patch))
    end

    it "displays the URL to untrash a trashed submission" do
      submission = double('submission', trashed?: true)
      expect(helper.trash_toggle(submission)).
        to eq(link_to("Un-Trash", trash_submission_path(submission),
                      method: :patch))

    end
  end
end
