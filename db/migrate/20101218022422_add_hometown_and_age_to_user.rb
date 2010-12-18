class AddHometownAndAgeToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :age, :integer
    add_column :users, :hometown, :string
  end

  def self.down
    remove_column :users, :age
    remove_column :users, :hometown
  end
end
