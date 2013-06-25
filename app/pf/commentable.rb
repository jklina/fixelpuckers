module Pf
  module Commentable
    def find_or_build_comment_from(author)
      where(author_id: author.id).first_or_initialize
    end
  end
end
