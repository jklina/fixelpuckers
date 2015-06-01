module Features
  module SubmissionHelpers
    def create_submission(author: create(:user))
      visit(new_submission_path(as: author.id))
      fill_in("Title", with: "Sub1")
      fill_in("Description", with: "meh notes")
      attach_file "Attachment", "spec/assets/files/photo.zip"
      attach_file "Preview", "spec/assets/images/photo.jpg"
      click_button("Create Submission")
    end
  end
end
