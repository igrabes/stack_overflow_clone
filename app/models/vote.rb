class VoteValidator < ActiveModel::Validator
  def validate(record)
    if record.user == record.voteable.user
      record.errors[:base] << "You cannot vote for your own questions or answers"
      return false
    end
    return true
  end
end

class Vote < ActiveRecord::Base
  #include VoteValidator

  belongs_to :voteable, :polymorphic => true
  belongs_to :user

  validates :value, :inclusion => {:in => [-1, 1]}
  validates_presence_of :user, :message => "You must be logged in to vote"
  validates_presence_of :voteable
  validates_with VoteValidator

  after_save :update_score

  private

  def update_score
    voteable.score = Vote.sum(:value, :conditions => {:voteable_id => voteable_id, :voteable_type => voteable_type})
    voteable.save!
  end

  
 # def voteable_user_uniqueness
  #  if (Vote.find(:first, :conditions => {:voteable_type => voteable_type, :user_id => user_id, :voteable_id => voteable_id}))
   #   return false
    #end
  #end

end

