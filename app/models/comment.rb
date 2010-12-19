class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  before_save :update_question_active_at

  def update_question_active_at
    question.update_active_at
    question.save!
  end

end
