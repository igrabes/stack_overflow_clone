class User < ActiveRecord::Base
  acts_as_authentic
  has_many :questions
  has_many :answers

  def age
    (Date.today - birthday).to_i/365 if birthday
  end

  def question_count
    questions.count
  end

  def upvoted_question?(question)
    QuestionVote.find(:first, :conditions => {:user_id => id, :question_id => question.id, :value => 1})
  end

  def downvoted_question?(question)
    QuestionVote.find(:first, :conditions => {:user_id => id, :question_id => question.id, :value => -1})
  end

end
