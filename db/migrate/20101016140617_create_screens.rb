class CreateScreens < ActiveRecord::Migration
  def self.up
    create_table :screens do |t|
      t.string :uuid
      t.string :video_id
      t.timestamps
    end
  end

  def self.down
    drop_table :screens
  end
end
