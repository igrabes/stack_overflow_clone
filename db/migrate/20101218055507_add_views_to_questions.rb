class AddViewsToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :views, :integer
    rename_column :questions, :topic, :title
  end

  def self.down
    remove_column :questions, :views
    rename_column :questions, :title, :topic
  end
end
