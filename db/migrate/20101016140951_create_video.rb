class CreateVideo < ActiveRecord::Migration
  create_table :videos do |t|
    t.string :title
    t.string :permalink
    t.string :mp4
    t.string :ogg
    t.integer :width
    t.integer :height
    t.timestamps
  end

  def self.down
    drop_table :videos
  end
end