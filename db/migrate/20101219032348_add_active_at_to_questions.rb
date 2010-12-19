class AddActiveAtToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :active_at, :datetime
  end

  def self.down
    remove_column :questions, :active_at
  end
end
