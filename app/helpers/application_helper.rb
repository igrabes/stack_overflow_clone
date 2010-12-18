module ApplicationHelper

  def pluralize_word(count, singular, plural=nil)
    pluralize(count, singular, plural).gsub(/^\S/, '')
  end

  def upvoted_question?(user, question)
    user && user.upvoted_question?(question)
  end

  def downvoted_question?(user, question)
    user && user.downvoted_question?(question)
  end
    
  def merge_params(p={})
      params.merge(p).delete_if{|k,v| v.blank?}
  end

end
