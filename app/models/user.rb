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

  def voted?(object, value)
    Vote.find(:first, :conditions => {:user_id => id, :voteable_id => object.id, :voteable_type => object.class.to_s, :value => value })
  end

end
