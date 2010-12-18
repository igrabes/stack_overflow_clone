class ViewsDefault < ActiveRecord::Migration
  def self.up
    change_column :questions, :views, :integer, :default => 0, :null => false
  end

  def self.down
  end
end
