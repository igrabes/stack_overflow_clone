class AddScoreToAnswersAndQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :score, :integer, :default => 0, :null => false
    add_column :answers, :score, :integer, :default => 0, :null => false
  end


  def self.down
    remove_column :questions, :score
    remove_column :answers, :score
  end
end
