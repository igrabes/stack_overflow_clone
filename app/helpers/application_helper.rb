module ApplicationHelper

  def pluralize_word(count, singular, plural=nil)
    pluralize(count, singular, plural).gsub(/^\S/, '')
  end

  def voted?(object, value)
    current_user && current_user.voted?(object, value)
  end

  def merge_params(p={})
      params.merge(p).delete_if{|k,v| v.blank?}
  end

end
