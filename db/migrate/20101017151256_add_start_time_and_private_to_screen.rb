class AddStartTimeAndPrivateToScreen < ActiveRecord::Migration
  def self.up
    add_column :screens, :start_time, :datetime
    add_column :screens, :private, :boolean, :default => false
  end

  def self.down
    remove_column :screens, :start_time
    remove_column :screens, :private
  end
end
