class AddEndtimeToScreen < ActiveRecord::Migration
  def self.up
    add_column :screens, :end_time, :datetime
  end

  def self.down
    remove_column :screens, :end_time
  end
end
