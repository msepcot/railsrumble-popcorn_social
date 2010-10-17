class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.integer :video_id
      t.text :text
      t.boolean :deleted
      t.string :source

      t.timestamps
    end
  end

  def self.down
    drop_table :notes
  end
end
