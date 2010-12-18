class AddTopicToQuestion < ActiveRecord::Migration
  def self.up
    add_column :questions, :topic, :string
  end

  def self.down
    remove_column :questions, :topic, :string
  end
end
