class Badge < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user
  @@badge_method_list = [:critic, :supporter, :student, :tumbleweed, :famous_question, :notable_question, :popular_question]

  def self.apply(user)
    badges = @@badge_method_list.map do |method|
      if self.send(method, user)
        Badge.new(:name => method, :user => user)
      end
    end
    badges.compact!
    user.badges = badges
  end

  def self.name_counts
    empty = Hash.new
    @@badge_method_list.each do |x|
      empty[x.to_s] = 0
    end
    counts = Badge.count(:all, :group => 'name', :order => 'name')
    counts.reverse_merge(empty)
    #empty.merge(counts)
  end
    
  def h_name
    self.name.to_s.humanize
  end

  private


  def self.critic(user)
    return user.votes.any? { |x| x.value == -1}
  end

  def self.supporter(user)
    return user.votes.any? { |x| x.value == 1}
  end

  def self.student(user)
    return user.questions.any? do |q|
      q.votes.any? {|v| v.value == 1}
    end
  end

  def self.tumbleweed(user)
    return user.questions.any? do |q|
      q.votes.count == 0 &&
      q.answers.count == 0 &&
      # q.comments.count == 0 &&
      q.views <= 10 &&
      q.created_at + 1.week < Time.now
    end
  end

  def self.famous_question(user)
    return user.questions.any? do |q|
      q.views >= 10000
    end
  end

  def self.notable_question(user)
    return user.questions.any? do |q|
      q.views >= 2500
    end
  end

  def self.popular_question(user)
    return user.questions.any? do |q|
      q.views >= 1000
    end
  end



end
