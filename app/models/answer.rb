class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  has_many :votes, :as => :voteable

  validates_presence_of :question, :user
  
  before_save :update_question_active_at

  def update_question_active_at
    question.update_active_at
    question.save!
  end

  def self.find_all_by_question_id(question_id)
    self.find(:all, :conditions => {:question_id => question_id})
  end

end
