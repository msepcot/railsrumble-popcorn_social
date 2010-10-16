class CreateViewings < ActiveRecord::Migration
  def self.up
    create_table :viewings do |t|
      t.integer :user_id
      t.integer :screen_id
      t.timestamps
    end
  end

  def self.down
    drop_table :viewings
  end
end
