class CreateVotesInitial < ActiveRecord::Migration
  def self.up
    create_table :question_votes do |t|
      t.integer :question_id
      t.integer :user_id
      t.boolean :upvote

      t.timestamps
    end
  end

  def self.down
    drop_table :question_votes
  end
end
