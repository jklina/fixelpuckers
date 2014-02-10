module SubmissionsHelper
  def trash_toggle(submission)
    if submission.trashed?
      link_to("Un-Trash", trash_submission_path(submission), method: :patch)
    else
      link_to("Trash", trash_submission_path(submission), method: :patch)
    end
  end
end
