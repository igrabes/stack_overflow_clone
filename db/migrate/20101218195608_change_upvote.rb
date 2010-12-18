class ChangeUpvote < ActiveRecord::Migration
  def self.up
    remove_column :question_votes, :upvote
    add_column :question_votes, :value, :integer
  end

  def self.down
    add_column :question_votes, :upvote, :boolean
    remove_column :question_votes, :value, :integer
  end
end
