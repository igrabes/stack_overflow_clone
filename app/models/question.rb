class Question < ActiveRecord::Base
  acts_as_taggable_on :tags

  belongs_to :user
  has_many :answers
  has_many :votes, :as => :voteable
  has_many :comments

  scope :sorted_by, lambda {|sort|
    if sort == "newest"
      order("created_at DESC")
    elsif sort == "votes"
      order("score DESC");
    elsif sort == "active"
      order("active_at DESC");
    elsif sort == "views"
      order("views DESC");
    end
  }

  scope :title_like, lambda {|title|
    where("questions.title LIKE ?",  "%" + title + "%")
  }

  scope :answered, lambda {|answered|
    if(answered.to_i == 1)
      joins("join answers on answers.question_id = questions.id").
      group("questions.id").
      where("answers.score > 0")
    else
      where("questions.id NOT IN (?)", Question.answered(1).map(&:id))
    end
  }

  scope :user_id_equals, lambda { |id|
    where(:user_id => id)
  }

  def excerpt
    if text 
      exc = text[0, 190]
      if exc != text
        exc += " ..."
      end
      return exc
    else
      return ""
    end
  end

  def up_votes
    Vote.count :all, :conditions => {:post_id => self.id, :value => 1, :type => :question}
  end

  def down_votes
    QuestionVote.count :all, :conditions => {:post_id => self.id, :value => -1, :type => :question}
  end

  def num_answers
    answers.count
  end

  def answered?
    Answer.count(:all, :conditions => ["question_id = ? AND score > 0", id]) > 0
  end

  def update_active_at
    self.active_at = Time.now
  end

  def self.filter(list_options)
    raise(ArgumentError, "Expected Hash, got #{list_options.inspect}") unless list_options.is_a?(Hash)
    ar_proxy = self
    list_options.each do |key, value|
      key = key.to_sym
      next unless self.list_option_names.include?(key)
      next if value.blank?
      puts "sending #{key} with #{value}"
      ar_proxy = ar_proxy.send(key, value)
    end
    ar_proxy.all()
  end

  def self.list_option_names
      self.scopes.map{|s| s.first}.push :tagged_with 
  end

end
