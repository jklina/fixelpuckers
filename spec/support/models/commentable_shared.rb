shared_examples "a commentable" do
  describe '#find_or_build_comment_from' do
    it "finds the author's comment when the author has a comment" do
      comment = FactoryGirl.create(:comment,
                                   commentable_id: commentable.id,
                                   commentable_type: commentable.class.to_s)
      expect(commentable.
             comments.
             find_or_build_comment_from(comment.author)).to eq(comment)
    end

    it "instantiates a new comment when a comment doesn't exist from the author" do
      author = FactoryGirl.create(:user)
      new_comment = commentable.comments.find_or_build_comment_from(author)
      expect(new_comment).to be_a_new(Comment)
      expect(new_comment.commentable).to eq(commentable)
    end
  end
end
