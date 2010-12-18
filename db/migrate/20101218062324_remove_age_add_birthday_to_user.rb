class RemoveAgeAddBirthdayToUser < ActiveRecord::Migration
  def self.up
    remove_column :users, :age
    add_column :users, :birthday, :date
  end

  def self.down
  end
end
