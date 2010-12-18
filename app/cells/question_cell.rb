class QuestionCell < Cell::Base
  helper ApplicationHelper

  def summary
    @question = @opts[:question]
    @excerpt = @opts[:excerpt] || false
    render
  end

end
