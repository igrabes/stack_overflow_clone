class Question < ActiveRecord::Base
  acts_as_taggable_on :tags

  belongs_to :user
  has_many :answers

  scope :sorted_by, lambda {|sort|
    if sort == "newest"
      order("created_at DESC")
    #elsif sort == "votes"
    #  order("
    end
  }

  def excerpt
    exc = text[0, 190]
    if exc != text
      exc += " ..."
    end
    exc
  end

  def up_votes
    Vote.count :all, :conditions => {:post_id => self.id, :value => 1, :type => :question}
  end

  def down_votes
    QuestionVote.count :all, :conditions => {:post_id => self.id, :value => -1, :type => :question}
  end

  #def vote_score
  #  QuestionVote.sum :value, :conditions => { :question_id => self.id, :type => :question}
  #end

  def num_answers
    answers.count
  end

  def answered?
    answers.count > 0
  end

end
