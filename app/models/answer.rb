class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  def self.find_all_by_question_id(question_id)
    self.find(:all, :conditions => {:question_id => question_id})
  end

end
